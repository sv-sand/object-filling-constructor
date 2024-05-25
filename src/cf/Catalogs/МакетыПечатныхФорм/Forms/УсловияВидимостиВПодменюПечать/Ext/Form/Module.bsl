﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ЗаполнитьСписокВыбораПоля();
	СписокУсловий = ТекущийОбъект.УсловиеВидимости.Получить();
	
	Если ТипЗнч(СписокУсловий) <> Тип("Массив") Тогда
		Возврат;
	КонецЕсли;
	
	ИдентификаторыВидовСравнения = ИдентификаторыВидовСравнения();
	ПредставленияВидовСравнения = ПредставленияВидовСравнения();
	
	Для Каждого Условие Из СписокУсловий Цикл
		ОписаниеПоля = ОписаниеПоля(Условие.Реквизит);
		Если ОписаниеПоля = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		ОписаниеУсловия = УсловияВидимости.Добавить();
		ЗаполнитьЗначенияСвойств(ОписаниеУсловия, ОписаниеПоля);
		ОписаниеУсловия.ВидСравнения = ИдентификаторыВидовСравнения[Условие.ВидСравнения];
		ОписаниеУсловия.ПредставлениеВидаСравнения = ПредставленияВидовСравнения[ОписаниеУсловия.ВидСравнения];
		ОписаниеУсловия.Значение =  Условие.Значение;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	ОбновитьПовторноИспользуемыеЗначения();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	СписокУсловий = Новый Массив;
	Для Каждого Условие Из УсловияВидимости Цикл
		ОписаниеУсловия = Новый Структура();
		ОписаниеУсловия.Вставить("Реквизит", Условие.Поле);
		ОписаниеУсловия.Вставить("ВидСравнения", ВидСравненияКомпоновкиДанных[Условие.ВидСравнения]);
		ОписаниеУсловия.Вставить("Значение", Условие.Значение);
		
		СписокУсловий.Добавить(ОписаниеУсловия);
	КонецЦикла;
	
	ТекущийОбъект.УсловиеВидимости = Новый ХранилищеЗначения(СписокУсловий, Новый СжатиеДанных(9));
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)

	Для Каждого Условие Из УсловияВидимости Цикл

		ИндексСтроки = УсловияВидимости.Индекс(Условие);
		Если Не ЗначениеЗаполнено(Условие.ВидСравнения) Тогда
			
			ТекстСообщения = НСтр("ru = 'Укажите вид сравнения'");
			Поле = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("УсловияВидимости[%1].ПредставлениеВидаСравнения", Формат(ИндексСтроки, "ЧГ=0;"));
			
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения, , Поле, , Отказ);
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(Условие.Поле) Тогда
			ТекстСообщения = НСтр("ru = 'Выберите поле'");
			Поле = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("УсловияВидимости[%1].ПредставлениеПоля", Формат(ИндексСтроки, "ЧГ=0;"));
			
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения, , Поле, , Отказ);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУсловияВидимости

&НаКлиенте
Процедура УсловияВидимостиПриАктивизацииСтроки(Элемент)
	
	УстановитьОграничениеТипа();
	
КонецПроцедуры

&НаКлиенте
Процедура УсловияВидимостиПолеОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.УсловияВидимости.ТекущиеДанные;
	ТекущиеДанные.Поле = ВыбранноеЗначение;
	Значение = Элементы.УсловияВидимостиПоле.СписокВыбора.НайтиПоЗначению(ВыбранноеЗначение);
	ВыбранноеЗначение = Значение.Представление;
	
	Если ТекущиеДанные.ВидСравнения = "Заполнено" Или ТекущиеДанные.ВидСравнения = "НеЗаполнено" Тогда
		ТекущиеДанные.Значение = Неопределено;
	КонецЕсли;
	
	УстановитьОграничениеТипа();
	
КонецПроцедуры


&НаКлиенте
Процедура УсловияВидимостиВидСравненияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ДанныеВыбора = Новый СписокЗначений();
	ДанныеВыбора.Добавить("Равно");
	ДанныеВыбора.Добавить("НеРавно");
	ДанныеВыбора.Добавить("Заполнено");
	ДанныеВыбора.Добавить("НеЗаполнено");
	ДанныеВыбора.Добавить("ВСписке");
	ДанныеВыбора.Добавить("НеВСписке");
	
	ПредставленияВидовСравнения = ПредставленияВидовСравнения();
	Для Каждого ОписаниеВидаСравнения Из ДанныеВыбора Цикл
		ОписаниеВидаСравнения.Представление = ПредставленияВидовСравнения[ОписаниеВидаСравнения.Значение];
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура УсловияВидимостиВидСравненияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.УсловияВидимости.ТекущиеДанные;
	ТекущиеДанные.ВидСравнения = ВыбранноеЗначение;
	ВыбранноеЗначение = ПредставленияВидовСравнения()[ВыбранноеЗначение];
	УстановитьОграничениеТипа();
	
КонецПроцедуры


&НаКлиенте
Процедура УсловияВидимостиВидСравненияПриИзменении(Элемент)
	
	УстановитьОграничениеТипа();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьСписокВыбораПоля()
	
	Для Каждого СтрокаТаблицы Из Объект.ИсточникиДанных Цикл
		ИсточникДанных = СтрокаТаблицы.ИсточникДанных;
		Если Не ЗначениеЗаполнено(ИсточникДанных) Тогда
			Продолжить;
		КонецЕсли;
		
		ОбъектМетаданных = ОбщегоНазначения.ОбъектМетаданныхПоИдентификатору(ИсточникДанных, Ложь);
		Если ОбъектМетаданных = Неопределено Тогда
			Возврат;
		КонецЕсли;
		
		КоллекцииРеквизитов = Новый Массив;
		КоллекцииРеквизитов.Добавить(ОбъектМетаданных.СтандартныеРеквизиты);
		КоллекцииРеквизитов.Добавить(ОбъектМетаданных.Реквизиты);
		
		Для Каждого КоллекцияРеквизитов Из КоллекцииРеквизитов Цикл
			Для Каждого Реквизит Из КоллекцияРеквизитов Цикл
				ОписаниеРеквизита = РеквизитыОбъекта.Добавить();
				ОписаниеРеквизита.Поле = Реквизит.Имя;
				ОписаниеРеквизита.Тип = Реквизит.Тип;
				ОписаниеРеквизита.ПредставлениеПоля = Реквизит.Представление();
				
				Элементы.УсловияВидимостиПоле.СписокВыбора.Добавить(ОписаниеРеквизита.Поле, ОписаниеРеквизита.ПредставлениеПоля);
			КонецЦикла;
		КонецЦикла;
	КонецЦикла;
	
	Элементы.УсловияВидимостиПоле.СписокВыбора.СортироватьПоПредставлению();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПредставленияВидовСравнения()
	
	Результат = Новый Соответствие();
	Результат.Вставить("Равно", НСтр("ru = 'Равно'"));
	Результат.Вставить("НеРавно", НСтр("ru = 'Не равно'"));
	Результат.Вставить("Заполнено", НСтр("ru = 'Заполнено'"));
	Результат.Вставить("НеЗаполнено", НСтр("ru = 'Не заполнено'"));
	Результат.Вставить("ВСписке", НСтр("ru = 'В списке'"));
	Результат.Вставить("НеВСписке", НСтр("ru = 'Не в списке'"));
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция ИдентификаторыВидовСравнения()
	
	Результат = Новый Соответствие();
	Результат.Вставить(ВидСравненияКомпоновкиДанных.Равно, "Равно");
	Результат.Вставить(ВидСравненияКомпоновкиДанных.НеРавно, "НеРавно");
	Результат.Вставить(ВидСравненияКомпоновкиДанных.Заполнено, "Заполнено");
	Результат.Вставить(ВидСравненияКомпоновкиДанных.НеЗаполнено, "НеЗаполнено");
	Результат.Вставить(ВидСравненияКомпоновкиДанных.ВСписке, "ВСписке");
	Результат.Вставить(ВидСравненияКомпоновкиДанных.НеВСписке, "НеВСписке");
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура УстановитьОграничениеТипа()
	
	ТекущиеДанные = Элементы.УсловияВидимости.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Или Не ЗначениеЗаполнено(ТекущиеДанные.Поле) Тогда
		Возврат;
	КонецЕсли;
	
	ОграничениеТипа = ТипЗначенияПоля(ТекущиеДанные.Поле);
	Если ТекущиеДанные.ВидСравнения = "Заполнено" Или ТекущиеДанные.ВидСравнения = "НеЗаполнено" Тогда
		ОграничениеТипа = Новый ОписаниеТипов();
		ТекущиеДанные.Значение = Неопределено;
	ИначеЕсли ТекущиеДанные.ВидСравнения = "ВСписке" Или ТекущиеДанные.ВидСравнения = "НеВСписке" Тогда
		ОграничениеТипа = Новый ОписаниеТипов("СписокЗначений");
	КонецЕсли;
	
	Элементы.УсловияВидимостиЗначение.ОграничениеТипа = ОграничениеТипа;
	ТекущиеДанные.Значение = ОграничениеТипа.ПривестиЗначение(ТекущиеДанные.Значение);
	
КонецПроцедуры

&НаКлиенте
Функция ТипЗначенияПоля(Поле)

	Тип = Неопределено;
	Если ЗначениеЗаполнено(Поле) Тогда
		НайденныеСтроки = РеквизитыОбъекта.НайтиСтроки(Новый Структура("Поле", Поле));
		Если НайденныеСтроки.Количество() > 0 Тогда
			Тип = НайденныеСтроки[0].Тип;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Тип;
	
КонецФункции

&НаСервере
Функция ОписаниеПоля(Поле)

	Если Не ЗначениеЗаполнено(Поле) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	НайденныеСтроки = РеквизитыОбъекта.НайтиСтроки(Новый Структура("Поле", Поле));
	Если НайденныеСтроки.Количество() > 0 Тогда
		Возврат НайденныеСтроки[0];
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	
	// ТолькоПросмотр для видов сравнения Заполнено и НеЗаполнено
	
	ЭлементОформления = УсловноеОформление.Элементы.Добавить();
	
	ОформляемоеПоле = ЭлементОформления.Поля.Элементы.Добавить();
	ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных(Элементы.УсловияВидимостиЗначение.Имя);
	
	ЭлементОтбора = ЭлементОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("УсловияВидимости.ВидСравнения");
	ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
	СписокВидовСравнения = Новый СписокЗначений();
	СписокВидовСравнения.Добавить("Заполнено");
	СписокВидовСравнения.Добавить("НеЗаполнено");
	ЭлементОтбора.ПравоеЗначение = СписокВидовСравнения;
	
	ЭлементОформления.Оформление.УстановитьЗначениеПараметра("ТолькоПросмотр", Истина);
	
КонецПроцедуры

#КонецОбласти
