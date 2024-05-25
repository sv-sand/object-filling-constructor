﻿
#Область Служебные

Процедура ЗаполнитьДеревоТипов()
	
	Дерево = РеквизитФормыВЗначение("ДеревоТипов");
	
	// Заполняем
	Для каждого Тип Из ОписаниеТипов.Типы() Цикл		
		Если Справочники.ТипВсеСсылки().СодержитТип(Тип) Тогда
			ДобавитьТип(Дерево, Справочники.ТипВсеСсылки(), Тип, БиблиотекаКартинок.Справочник)	
			
		ИначеЕсли Документы.ТипВсеСсылки().СодержитТип(Тип) Тогда
			ДобавитьТип(Дерево, Документы.ТипВсеСсылки(), Тип, БиблиотекаКартинок.Документ)	
				
		КонецЕсли;		
	КонецЦикла;
	
	// Сортируем только внутри видов
	Для каждого СтрокаВида Из Дерево.Строки Цикл
		СтрокаВида.Строки.Сортировать("Представление");
	КонецЦикла;
	
	ЗначениеВРеквизитФормы(Дерево, "ДеревоТипов");
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьТип(Дерево, КорневойТип, Тип, Картинка)
	
	КорневаяСтрока = Дерево.Строки.Найти(КорневойТип, "Тип");
	Если КорневаяСтрока = Неопределено Тогда
		КорневаяСтрока = Дерево.Строки.Добавить();	
		КорневаяСтрока.Тип = КорневойТип;
		КорневаяСтрока.Представление = Строка(КорневаяСтрока.Тип);
		КорневаяСтрока.Картинка = Картинка;
	КонецЕсли;
	
	Строка = КорневаяСтрока.Строки.Найти(Тип, "Тип");
	Если Строка = Неопределено Тогда
		Строка = КорневаяСтрока.Строки.Добавить();	
		Строка.Тип = Тип;
		Строка.Представление = Строка(Тип);
		Строка.Картинка = Картинка;	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьТип()
	
	Строка = Элементы.ДеревоТипов.ТекущиеДанные;
	Если Строка = Неопределено Тогда		
		Возврат;		
	КонецЕсли;	
	
	Закрыть(Строка.Тип);
	
КонецПроцедуры

#КонецОбласти

#Область СобытияФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("ОписаниеТипов", ОписаниеТипов);
	
	ЗаполнитьДеревоТипов();
		
КонецПроцедуры

#КонецОбласти

#Область СобытияЭлементовФормы

&НаКлиенте
Процедура ДеревоТиповВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ВыбратьТип();	
		
КонецПроцедуры

&НаКлиенте
Процедура Выбрать(Команда)
	
	ВыбратьТип();	
	
КонецПроцедуры

#КонецОбласти
