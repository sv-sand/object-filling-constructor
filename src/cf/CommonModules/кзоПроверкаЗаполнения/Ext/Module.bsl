﻿
#Область ПрограммныйИНтерфейс

#Область ПодпискаНаСобытия

// Обработчик подписки на событие ОбработкаПроверкиЗаполнения
//
// Параметры:
//  Источник			 - Объект	 - Заполняемый объект
//  Отказ				 - Булево	 - Флаг отказа
//  ПроверяемыеРеквизиты - Массив	 - Реквизиты для проверки заполнения
//
Процедура ОбработкаПроверкиЗаполнения(Источник, Отказ, ПроверяемыеРеквизиты) Экспорт
	
	Если Источник.ОбменДанными.Загрузка Тогда
		Возврат;	
	КонецЕсли;
	
	ПроверитьЗаполнение(Источник, Отказ);
	
КонецПроцедуры

#КонецОбласти

// Проверяет заполнение объекта по правилам и выдает ошибки
//
// Параметры:
//  Объект	 - СправочникОбъект, ДокументОбъект	 - Объект для заполнения
//  Отказ	 - Булево							 - Флаг отказа
//
Процедура ПроверитьЗаполнение(Объект, Отказ) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	// Получаем подходящие правила
	Дата = кзоСлужебные.ПолучитьДатуОбъекта(Объект);
	
	РезультатЗапроса = ПолучитьПравилаПроверкиЗаполнения(Объект, Дата, ПараметрыСеанса.ТекущийПользователь);
	Если РезультатЗапроса.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	// Проверяем каждое правло
	Правило = РезультатЗапроса.Выбрать();	
	Пока Правило.Следующий() Цикл		
		Если НЕ ПроверкаТолькоНовые(Объект, Правило) Тогда
			Продолжить;
		КонецЕсли;
		
		Параметры = НовыеПараметры(Объект, Правило);		
		Параметры.ТаблицаДанных = кзоСКД.СоздатьДанныеСКД(Объект, Правило.ИмяТаблицы, Объект.Ссылка.Метаданные());
		Параметры.СКД = кзоСКД.СоздатьСКД(Правило.ОбъектМетаданных, Правило.ИмяТаблицы);
		Параметры.НастройкиКомпоновки = кзоСКД.ПолучитьНастройкиКомпоновки(Параметры.СКД);
		
		Настройки = Правило.ХранилищеНастроек.Получить();	
		
		Если Настройки.Свойство("НастройкиОтбора") Тогда			
			ВыполнитьОтборДанных(Параметры, Настройки.НастройкиОтбора);
		КонецЕсли;
		
		Если Настройки.Свойство("НастройкиПроверки") Тогда
			ПроверитьЗаполнениеОбъекта(Параметры, Настройки.НастройкиПроверки, Отказ);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область Правила

Функция ПолучитьПравилаПроверкиЗаполнения(Объект, Дата, Пользователь)
	
	УстановитьПривилегированныйРежим(Истина);
	
	ОбъектМетаданных = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(ТипЗнч(Объект.Ссылка));
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ГруппыПользователей.Ссылка КАК Группа
		|ПОМЕСТИТЬ ВТГруппыПользователя
		|ИЗ
		|	Справочник.ГруппыПользователей.Состав КАК ГруппыПользователей
		|ГДЕ
		|	ГруппыПользователей.Пользователь = &Пользователь
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	Правила.Ссылка КАК Правило
		|ПОМЕСТИТЬ ВТАктивныеПравила
		|ИЗ
		|	Справочник.кзоПравилаПроверкиЗаполнения КАК Правила
		|ГДЕ
		|	Правила.ОбъектМетаданных = &ОбъектМетаданных
		|	И Правила.Активно
		|	И НЕ Правила.ПометкаУдаления
		|	И (&Дата = ДАТАВРЕМЯ(1, 1, 1)
		|			ИЛИ ВЫБОР
		|				КОГДА Правила.НачалоПериода = ДАТАВРЕМЯ(1, 1, 1)
		|					ТОГДА ИСТИНА
		|				ИНАЧЕ Правила.НачалоПериода >= НАЧАЛОПЕРИОДА(&Дата, ДЕНЬ)
		|			КОНЕЦ)
		|	И ВЫБОР
		|			КОГДА Правила.КонецПериода = ДАТАВРЕМЯ(1, 1, 1)
		|				ТОГДА ИСТИНА
		|			ИНАЧЕ Правила.КонецПериода <= НАЧАЛОПЕРИОДА(&Дата, ДЕНЬ)
		|		КОНЕЦ
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	1 КАК ПриоритетПользователя,
		|	ВТАктивныеПравила.Правило КАК Правило
		|ПОМЕСТИТЬ ВТПравила
		|ИЗ
		|	ВТАктивныеПравила КАК ВТАктивныеПравила
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.кзоПравилаПроверкиЗаполнения.ГруппыПользователей КАК ГруппыПользователей
		|		ПО ВТАктивныеПравила.Правило = ГруппыПользователей.Ссылка
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.кзоПравилаПроверкиЗаполнения.Пользователи КАК ПравилаПользователей
		|		ПО ВТАктивныеПравила.Правило = ПравилаПользователей.Ссылка
		|ГДЕ
		|	ГруппыПользователей.Группа ЕСТЬ NULL
		|	И ПравилаПользователей.Пользователь ЕСТЬ NULL
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	2,
		|	ВТАктивныеПравила.Правило
		|ИЗ
		|	ВТАктивныеПравила КАК ВТАктивныеПравила
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.кзоПравилаПроверкиЗаполнения.ГруппыПользователей КАК ГруппыПользователей
		|		ПО ВТАктивныеПравила.Правило = ГруппыПользователей.Ссылка
		|ГДЕ
		|	ГруппыПользователей.Группа В
		|			(ВЫБРАТЬ
		|				Т.Группа
		|			ИЗ
		|				ВТГруппыПользователя КАК Т)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	3,
		|	ВТАктивныеПравила.Правило
		|ИЗ
		|	ВТАктивныеПравила КАК ВТАктивныеПравила
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.кзоПравилаПроверкиЗаполнения.Пользователи КАК ПравилаПользователей
		|		ПО ВТАктивныеПравила.Правило = ПравилаПользователей.Ссылка
		|ГДЕ
		|	ПравилаПользователей.Пользователь = &Пользователь
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|УНИЧТОЖИТЬ ВТГруппыПользователя
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|УНИЧТОЖИТЬ ВТАктивныеПравила
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТПравила.Правило КАК Ссылка,
		|	ВТПравила.ПриоритетПользователя КАК ПриоритетПользователя,
		|	Правила.ОбъектМетаданных КАК ОбъектМетаданных,
		|	Правила.ХранилищеНастроек КАК ХранилищеНастроек,
		|	Правила.ИмяТаблицы КАК ИмяТаблицы,
		|	Правила.ТолькоНовые КАК ТолькоНовые
		|ИЗ
		|	ВТПравила КАК ВТПравила
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.кзоПравилаПроверкиЗаполнения КАК Правила
		|		ПО ВТПравила.Правило = Правила.Ссылка
		|
		|УПОРЯДОЧИТЬ ПО
		|	ПриоритетПользователя";
	
	Запрос.УстановитьПараметр("Дата", Дата);
	Запрос.УстановитьПараметр("ОбъектМетаданных", ОбъектМетаданных);
	Запрос.УстановитьПараметр("Пользователь", Пользователь);
	
	Возврат Запрос.Выполнить();
			
КонецФункции

Функция ПроверкаТолькоНовые(Объект, Правило)

	Если НЕ Правило.ТолькоНовые Тогда
		Возврат Истина;
	КонецЕсли;
	
	ЭтоНовый = Объект.ЭтоНовый();
	Если ОбщегоНазначения.ВидОбъектаПоСсылке(Объект.Ссылка) = "Документ" Тогда
		// У документа подписка "ОбработкаПроверкиЗаполнения" вызывается только в момент проведения
		// Следовательно, появляется "дыра" - можно записать документ и потом его провести, проверка не сработает
		ЭтоНовый = Истина;		
	КонецЕсли;
	
	Возврат ЭтоНовый;
	
КонецФункции

Функция НовыеПараметры(Объект, Правило)
	
	Параметры = Новый Структура("Объект, Правило, ТаблицаДанных, СКД, НастройкиКомпоновки", Объект, Правило);
	
	Возврат Параметры;
		
КонецФункции

#КонецОбласти

#Область Отборы

Процедура ВыполнитьОтборДанных(Параметры, НастройкиОтбора)

	кзоСКД.УстановитьНастройкиКомпоновкиДляОтбораОбъектов(Параметры.НастройкиКомпоновки, Параметры.Правило.ИмяТаблицы);
	кзоСКД.ЗаполнитьОтборИзМассива(Параметры.НастройкиКомпоновки.Отбор, НастройкиОтбора);
	
	РезультатОтбора = кзоСКД.ПолучитьРезультатСКД(Параметры.СКД, Параметры.НастройкиКомпоновки, Параметры.ТаблицаДанных);
	
	Если ЗначениеЗаполнено(Параметры.Правило.ИмяТаблицы) Тогда
		ОтфильтроватьТаблицуДанныхПоНомерамСтрок(Параметры.ТаблицаДанных, РезультатОтбора, Параметры.Правило.ИмяТаблицы);
	Иначе
		ОтфильтроватьТаблицуДанныхПоСсылке(Параметры.ТаблицаДанных, РезультатОтбора);
	КонецЕсли;	
	
КонецПроцедуры

Процедура ОтфильтроватьТаблицуДанныхПоСсылке(ТаблицаДанных, РезультатОтбора)
	
	Индекс = 0;
	Пока Индекс < ТаблицаДанных.Количество() Цикл
		Строка = ТаблицаДанных.Получить(Индекс);
		
		Если РезультатОтбора.Найти(Строка.Ссылка, "Ссылка") = Неопределено Тогда
			ТаблицаДанных.Удалить(Индекс);	
			Продолжить;
		КонецЕсли;
		
		Индекс = Индекс + 1;
	КонецЦикла;
	
КонецПроцедуры

Процедура ОтфильтроватьТаблицуДанныхПоНомерамСтрок(ТаблицаДанных, РезультатОтбора, ИмяТаблицы = "")
	
	Индекс = 0;
	Пока Индекс < ТаблицаДанных.Количество() Цикл
		Строка = ТаблицаДанных.Получить(Индекс);
		
		НомерСтроки = Строка[ИмяТаблицы + кзоСКД.РазделительРеквизитаТабличнойЧасти() + "НомерСтроки"];
		Если РезультатОтбора.Найти(НомерСтроки, ИмяТаблицы + "НомерСтроки") = Неопределено Тогда
			ТаблицаДанных.Удалить(Индекс);	
			Продолжить;
		КонецЕсли;;
		
		Индекс = Индекс + 1;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ПроверкаЗаполнения

Процедура ПроверитьЗаполнениеОбъекта(Параметры, НастройкиПроверки, Отказ)
	
	Если Параметры.ТаблицаДанных.Количество() = 0 Тогда
		Возврат;	
	КонецЕсли;
	
	// Проверяем корректность заполнения
	кзоСКД.УстановитьНастройкиКомпоновкиДляПроверкиПравилЗаполнения(Параметры.Правило.ИмяТаблицы, Параметры.НастройкиКомпоновки, НастройкиПроверки);		
	РезультатПроверки = кзоСКД.ПолучитьРезультатСКД(Параметры.СКД, Параметры.НастройкиКомпоновки, Параметры.ТаблицаДанных);
	
	// Разбираем ошибки заполнения
	Если ЗначениеЗаполнено(Параметры.Правило.ИмяТаблицы) Тогда
		Таблица = Параметры.Объект[Параметры.Правило.ИмяТаблицы];
		
		Для каждого СтрокаДанных Из Параметры.ТаблицаДанных Цикл
			НомерСтроки = СтрокаДанных[Параметры.Правило.ИмяТаблицы + кзоСКД.РазделительРеквизитаТабличнойЧасти() + "НомерСтроки"];
			Строка = Таблица.Найти(НомерСтроки, "НомерСтроки");
			
			ОтборСтрок = Новый Структура(Параметры.Правило.ИмяТаблицы + "НомерСтроки", НомерСтроки);
			НайденныеСтроки = РезультатПроверки.НайтиСтроки(ОтборСтрок);	
			
			ЗаполнитьОшибкиЗаполнения(НастройкиПроверки, НайденныеСтроки);
			ВывестиОшибкиЗаполнения(Параметры.Объект, Параметры.Правило, Строка, НастройкиПроверки, Отказ);
		КонецЦикла;
		
	Иначе
		ЗаполнитьОшибкиЗаполнения(НастройкиПроверки, РезультатПроверки);
		ВывестиОшибкиЗаполнения(Параметры.Объект, Параметры.Правило, Неопределено, НастройкиПроверки, Отказ);
	КонецЕсли;	
		
КонецПроцедуры

Процедура ЗаполнитьОшибкиЗаполнения(НастройкиПроверки, РезультатПроверки)

	Для каждого СтруктураОтбора Из НастройкиПроверки Цикл
		Если НЕ СтруктураОтбора.Использование Тогда
			Продолжить;
		КонецЕсли;	
	
		ИмяКолонки = СтрЗаменить(СтруктураОтбора.ПутьКДанным, ".", "");
		СтруктураОтбора.Вставить("ПроверкаУспешна", ПроверкаУспешна(РезультатПроверки, ИмяКолонки));
		
		Если СтруктураОтбора.Тип = Тип("ГруппаЭлементовОтбораКомпоновкиДанных") Тогда
			ЗаполнитьОшибкиЗаполнения(СтруктураОтбора.Элементы, РезультатПроверки)	
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Функция ПроверкаУспешна(РезультатПроверки, ИмяКолонки)

	Для каждого Строка Из РезультатПроверки Цикл
		Если Строка[ИмяКолонки] = Истина Тогда
			Возврат Истина;	
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

Процедура ВывестиОшибкиЗаполнения(Источник, Правило, Строка, НастройкиПроверки, Отказ)

	Для каждого СтруктураОтбора Из НастройкиПроверки Цикл
		Если НЕ СтруктураОтбора.Использование 
			ИЛИ СтруктураОтбора.ПроверкаУспешна
			Тогда
			Продолжить;
		КонецЕсли;
		
		Если СтруктураОтбора.Тип = Тип("ГруппаЭлементовОтбораКомпоновкиДанных") Тогда
			ВывестиОшибкиЗаполнения(Источник, Правило, Строка, СтруктураОтбора.Элементы, Отказ);			
		Иначе
			
			ПолноеИмяРеквизита = Строка(СтруктураОтбора.ЛевоеЗначение);
			
			Если ЗначениеЗаполнено(Правило.ИмяТаблицы) 
				И СтрНачинаетсяС(ПолноеИмяРеквизита, Правило.ИмяТаблицы) 
				Тогда
				Мета = МетаданныеРеквизитаТабличнойЧастиОбъекта(Источник, Правило.ИмяТаблицы, Строка, ПолноеИмяРеквизита);
			Иначе	
				Мета = МетаданныеРеквизитаОбъекта(Источник, ПолноеИмяРеквизита);	
			КонецЕсли;
			
			Текст = СформироватьТекстОшибки(СтруктураОтбора, Мета);			
			
			ОбщегоНазначения.СообщитьПользователю(Текст, Источник, Мета.ПолеСообщения, , Отказ);					
			
			Текст = СтрШаблон("Правило %1, имя таблицы %2, описание ошибки заполнения: %3", Правило.Ссылка, Правило.ИмяТаблицы, Текст);				
			ЗаписьЖурналаРегистрации("КЗО.ПроверкаЗаполнения", УровеньЖурналаРегистрации.Предупреждение, Источник.Метаданные(), Источник.Ссылка, Текст);
			
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Функция СформироватьТекстОшибки(СтруктураОтбора, Мета)

	Текст = СтрШаблон("Неверно заполнено поле ""%1""", Мета.Представление);
	
	Если ЗначениеЗаполнено(Мета.ИмяТаблицы) Тогда
		Текст = Текст + СтрШаблон(" в строке %1 таблицы ""%2""", Мета.НомерСтроки, Мета.ИмяТаблицы);	
	КонецЕсли;
	
	Если Мета.ИмеетВложенные Тогда
		Текст = Текст + СтрШаблон(", реквизит ""%1"" имеет недопустимое значение '%2'",
			Мета.ПредставлениеВложенных,
			Мета.Значение
		);		
	КонецЕсли;
	
	Текст = Текст + СтрШаблон(", %1", ПредставлениеРазрешенногоЗначения(СтруктураОтбора));
	
	Возврат Текст;
	
КонецФункции

#Область Метаданные

Функция МетаданныеРеквизитаОбъекта(Источник, Знач ПолноеИмяРеквизита)
	
	Реквизиты = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ПолноеИмяРеквизита, ".");		
	
	Мета = Новый Структура();
	Мета.Вставить("ИмяРеквизита", Реквизиты.Получить(0));
	Мета.Вставить("ИмеетВложенные", Реквизиты.Количество() > 1);
	Мета.Вставить("ИмяВложенных", ВложенныеРеквизиты(ПолноеИмяРеквизита));	
	Мета.Вставить("Представление", ПредставлениеРеквизитаОбъекта(Источник.Метаданные(), Мета.ИмяРеквизита));
	Мета.Вставить("ПредставлениеСВложенными", ПредставлениеРеквизитаОбъектаСВложенными(Источник, ПолноеИмяРеквизита));
	Мета.Вставить("ПредставлениеВложенных", ВложенныеРеквизиты(Мета.ПредставлениеСВложенными));
    Мета.Вставить("ПолеСообщения", Мета.ИмяРеквизита);
    Мета.Вставить("ИмяТаблицы", "");
	
	Если Мета.ИмеетВложенные Тогда
		Мета.Вставить("Значение", ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Источник[Мета.ИмяРеквизита], Мета.ИмяВложенных));
	Иначе
		Мета.Вставить("Значение", Источник[Мета.ИмяРеквизита]);
	КонецЕсли;
	
	Возврат Мета;
	
КонецФункции

Функция МетаданныеРеквизитаТабличнойЧастиОбъекта(Источник, ИмяТаблицы, Строка, Знач ПолноеИмяРеквизита)
	
	ПолноеИмяРеквизита = Сред(ПолноеИмяРеквизита, СтрДлина(ИмяТаблицы) + 2);
	
	Реквизиты = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ПолноеИмяРеквизита, ".");		
	
	Мета = Новый Структура();
	Мета.Вставить("ИмяТаблицы", ИмяТаблицы);
	Мета.Вставить("НомерСтроки", Строка.НомерСтроки);
	Мета.Вставить("ИмяРеквизита", Реквизиты.Получить(0));
	Мета.Вставить("ИмеетВложенные", Реквизиты.Количество() > 1);
	Мета.Вставить("ИмяВложенных", ВложенныеРеквизиты(ПолноеИмяРеквизита));	
	Мета.Вставить("Представление", ПредставлениеРеквизитаОбъекта(Источник.Метаданные().ТабличныеЧасти[ИмяТаблицы], Мета.ИмяРеквизита));
	Мета.Вставить("ПредставлениеСВложенными", ПредставлениеРеквизитаТабличнойЧастиСВложенными(Источник, ИмяТаблицы, Строка, ПолноеИмяРеквизита));
	Мета.Вставить("ПредставлениеВложенных", ВложенныеРеквизиты(Мета.ПредставлениеСВложенными));

	Если Мета.ИмеетВложенные Тогда
		Мета.Вставить("Значение", ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Строка[Мета.ИмяРеквизита], Мета.ИмяВложенных));
	Иначе
		Мета.Вставить("Значение", Строка[Мета.ИмяРеквизита]);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ИмяТаблицы) Тогда
		Текст = СтрШаблон("%1[%2].%3", 
			ИмяТаблицы,
			Строка.НомерСтроки - 1,
			Мета.ИмяРеквизита
		);
		Мета.Вставить("ПолеСообщения", Текст);
	Иначе
		Мета.Вставить("ПолеСообщения", Мета.ИмяРеквизита);	
	КонецЕсли;
	
	Возврат Мета;
	
КонецФункции

Функция ВложенныеРеквизиты(ПолноеИмяРеквизита)

	Массив = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ПолноеИмяРеквизита, ".");
	Массив.Удалить(0);
	
	Возврат СтрСоединить(Массив, ".");

КонецФункции

Функция ПредставлениеРеквизитаОбъекта(Метаданные, ИмяРеквизита)
	
	Реквизит = Метаданные.Реквизиты.Найти(ИмяРеквизита);
	Если Реквизит <> Неопределено Тогда
		Возврат Реквизит.Синоним;
	КонецЕсли;
	
	Для каждого Реквизит Из Метаданные.СтандартныеРеквизиты Цикл
		Если Реквизит.Имя = ИмяРеквизита Тогда
			Если ЗначениеЗаполнено(Реквизит.Синоним) Тогда
				Возврат Реквизит.Синоним;
			Иначе
				Возврат Реквизит.Имя;
			КонецЕсли;
		КонецЕсли;	
	КонецЦикла;
	
	Возврат ИмяРеквизита;
		
КонецФункции

Функция ПредставлениеРеквизитаОбъектаСВложенными(Источник, ПолноеИмяРеквизита)
	
	Реквизиты = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ПолноеИмяРеквизита, ".");
	Если Реквизиты.Количество() = 0 Тогда
		Возврат "";	
	КонецЕсли;
	
	// Первый реквизит не надо вычитывать из базы
	ИмяРеквизита = Реквизиты.Получить(0);
	
	Представления = Новый Массив;
	Представления.Добавить(ПредставлениеРеквизитаОбъекта(Источник.Метаданные(), ИмяРеквизита));
	
	Объект = Источник[ИмяРеквизита];
	Реквизиты.Удалить(0);
	
	// Последующие вычитываем из базы
	Для каждого ИмяРеквизита Из Реквизиты Цикл
		Представления.Добавить(ПредставлениеРеквизитаОбъекта(Объект.Метаданные(), ИмяРеквизита));
		
		Объект = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект, ИмяРеквизита);			
	КонецЦикла;
	
	Возврат СтрСоединить(Представления, ".");
		
КонецФункции

Функция ПредставлениеРеквизитаТабличнойЧастиСВложенными(Источник, ИмяТаблицы, Строка, ПолноеИмяРеквизита)
	
	Реквизиты = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ПолноеИмяРеквизита, ".");
	ИмяРеквизита = Реквизиты.Получить(0);
	
	Реквизиты.Удалить(0);
	ИмяВложенных = СтрСоединить(Реквизиты, ".");
	
	Мета = Источник.Метаданные().ТабличныеЧасти[ИмяТаблицы];
	ПредставлениеРеквизита = ПредставлениеРеквизитаОбъекта(Мета, ИмяРеквизита);
	
	Если ЗначениеЗаполнено(ИмяВложенных) Тогда
		ПредставлениеВложенных = ПредставлениеРеквизитаОбъектаСВложенными(Строка[ИмяРеквизита], ИмяВложенных);	
		ПредставлениеРеквизита = ПредставлениеВложенных + "." + ПредставлениеВложенных;
	КонецЕсли;
	
	Возврат ПредставлениеРеквизита;
		
КонецФункции

Функция ПредставлениеРазрешенногоЗначения(СтруктураОтбора)
	
	Значение = "'" + СтруктураОтбора.ПравоеЗначение + "'";
	
	Если СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено Тогда
		Текст = "значение не заполнено";
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено Тогда
		Текст = "значение должно быть не заполнено";
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно Тогда
		Текст = СтрШаблон("разрешенное значение %1", Значение);	
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно Тогда
		Текст = СтрШаблон("запрещено значение %1", Значение);	
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке Тогда
		Текст = СтрШаблон("разрешены значения из списка: %1", Значение);	
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НеВСписке Тогда
		Текст = СтрШаблон("запрещены значения из списка: %1", Значение);	
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВИерархии Тогда
		Текст = СтрШаблон("разрешены только значения из группы %1", Значение);	
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НеВИерархии Тогда
		Текст = СтрШаблон("запрещены значения из группы %1", Значение);	
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСпискеПоИерархии Тогда
		Текст = СтрШаблон("разрешены значения из списка и вложенные в группы: %1", Значение);	
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НеВСпискеПоИерархии Тогда
		Текст = СтрШаблон("запрещены значения из списка и вложенные в группы: %1", Значение);	
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Содержит Тогда
		Текст = СтрШаблон("значение должно содержать ""%1""", Значение);
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НеСодержит Тогда
		Текст = СтрШаблон("значение не должно содержать ""%1""", Значение);
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Подобно Тогда
		Текст = СтрШаблон("значение должно быть подобно шаблону ""%1""", Значение);
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НеПодобно Тогда
		Текст = СтрШаблон("значение не должно быть подобно шаблону ""%1""", Значение);
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Больше Тогда
		Текст = СтрШаблон("значение должно быть больше %1", Значение);
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Меньше Тогда
		Текст = СтрШаблон("значение должно быть меньше %1", Значение);
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.БольшеИлиРавно Тогда
		Текст = СтрШаблон("значение должно быть больше или равно %1", Значение);
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.МеньшеИлиРавно Тогда
		Текст = СтрШаблон("значение должно быть меньше или равно %1", Значение);
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НачинаетсяС Тогда
		Текст = СтрШаблон("разрешены значения начинающиеся с ""%1""", Значение);	
		
	ИначеЕсли СтруктураОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НеНачинаетсяС Тогда
		Текст = СтрШаблон("запрещены значения начинающиеся с ""%1""", Значение);	
		
	Иначе
		Текст = СтрШаблон("не корректное значение %1", Значение);
	КонецЕсли;
	
	Возврат Текст;
		
КонецФункции

#КонецОбласти

#КонецОбласти
