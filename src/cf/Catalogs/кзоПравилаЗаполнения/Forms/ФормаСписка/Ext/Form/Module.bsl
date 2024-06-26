﻿
#Область Команды
 
&НаКлиенте
Процедура Активировать(Команда)
	
	АктивироватьНаСервере();	
	Элементы.Список.Обновить();
	
КонецПроцедуры

&НаСервере
Процедура АктивироватьНаСервере()
	
	Для каждого Ссылка Из Элементы.Список.ВыделенныеСтроки Цикл
		Документ = Ссылка.ПолучитьОбъект();
		Документ.Активно = Истина;
		Документ.Записать();
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура Деактивировать(Команда)
	
	ДеактивироватьНаСервере();
	Элементы.Список.Обновить();
	
КонецПроцедуры

&НаСервере
Процедура ДеактивироватьНаСервере()
	
	Для каждого Ссылка Из Элементы.Список.ВыделенныеСтроки Цикл
		Документ = Ссылка.ПолучитьОбъект();
		Документ.Активно = Ложь;
		Документ.Записать();
	КонецЦикла;
	
КонецПроцедуры

#Область ВыгрузкаЗагрузка

&НаКлиенте
Процедура ВыгрузитьВФайл(Команда)
	
	Правила = ВыгрузитьВФайлПолучитьПравила();
	Если Правила.Количество() = 0 Тогда
		ПоказатьПредупреждение(, "Не выбрано ни одной строки", 10, "ВНИМАНИЕ!");
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура("Режим, Правила", "Выгрузка", Правила);
	
	ОткрытьФорму("Обработка.кзоВыгрузкаЗагрузкаПравил.Форма", ПараметрыФормы, ЭтаФорма, КлючУникальности, , , , РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаСервере
Функция ВыгрузитьВФайлПолучитьПравила()

	Правила = Новый Массив;
	Для каждого Правило Из Элементы.Список.ВыделенныеСтроки Цикл
		Структура = Новый Структура("Правило", Правило);		
		Правила.Добавить(Структура);
	КонецЦикла;
	
	Возврат Правила;
	
КонецФункции

&НаКлиенте
Процедура ЗагрузитьИзФайла(Команда)
	
	ПараметрыФормы = Новый Структура("Режим", "Загрузка");
	
	ОткрытьФорму("Обработка.кзоВыгрузкаЗагрузкаПравил.Форма", ПараметрыФормы, ЭтаФорма, КлючУникальности, , , , РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);	
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "кзоПравилаЗаполнения.ОбновитьСписок" Тогда
		Элементы.Список.Обновить();	
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти