﻿
#Область ПрограммныйИнтерфейс

// Возвращает структуру обработчика элемента формы
// 
// Возвращаемое значение:
//  Структура - Структура обработчика элемента формы
//
Функция НоваяСтруктураОбработчика() Экспорт

	СтруктураОбработчика = Новый Структура("ИмяЭлемента, ИмяСобытия, Событие, ТиповоеДействие, ТиповойОбработчик, МоментВыполнения");
	
	Возврат СтруктураОбработчика;
	
КонецФункции

// Возвращает структуру обработчика в кеше формы
//
// Параметры:
//  Форма		 - ФормаКлиентскогоПриложения	 - Форма
//  ИмяЭлемента	 - Строка						 - Имя элемента формы
//  ИмяСобытия	 - Строка						 - Имя события элемента формы
// 
// Возвращаемое значение:
//  Структура - Структура обработчика, см. НоваяСтруктураОбработчика()
//
Функция НайтиОбработчикВКешеФормы(Форма, ИмяЭлемента, ИмяСобытия) Экспорт
	
	Кеш = Форма.кзоПараметры.КешОбработчиковСобытий;
	
	Для каждого СтруктураОбработчика Из Кеш Цикл
		Если СтруктураОбработчика.ИмяЭлемента = ИмяЭлемента
			И СтруктураОбработчика.ИмяСобытия = ИмяСобытия
			Тогда
			Возврат СтруктураОбработчика;
		КонецЕсли;	
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

#КонецОбласти