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
	
	Параметры.Свойство("ПроблемныйОбъект", ПроблемныйОбъект);
	Параметры.Свойство("Описание", Описание);
	Параметры.Свойство("ТипПредупреждения", ТипПредупреждения);
	Параметры.Свойство("УзелИнформационнойБазы", УзелИнформационнойБазы);
	Параметры.Свойство("ВерсияИзДругойПрограммы", ВерсияИзДругойПрограммы);
	Параметры.Свойство("ВерсияЭтойПрограммы", ВерсияЭтойПрограммы);
	Параметры.Свойство("СкрытьПредупреждение", СкрытьПредупреждение);
	Параметры.Свойство("ДатаВозникновения", ДатаВозникновения);
	Параметры.Свойство("КомментарийПредупреждения", КомментарийПредупреждения);
	
	ТребуетсяОбновлениеПризнакаСкрытьИзСписка = Ложь;
	ТребуетсяОбновлениеКомментария = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ИзменитьКартинкуДекорации()
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СкрытьПредупреждениеПриИзменении(Элемент)
	
	ТребуетсяОбновлениеПризнакаСкрытьИзСписка = Истина;
	
	Если СкрытьПредупреждение Тогда
		
		Элементы.ДекорацияКартинка.Картинка = БиблиотекаКартинок.Информация32;
		
	Иначе
		
		Элементы.ДекорацияКартинка.Картинка = БиблиотекаКартинок.Ошибка32;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроблемныйОбъектНажатие(Элемент, СтандартнаяОбработка)
	
	ТребуетсяОбновлениеПризнакаСкрытьИзСписка = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура КомментарийПредупрежденияПриИзменении(Элемент)
	
	ТребуетсяОбновлениеКомментария = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОткрытьВерсию(Команда)
	
	Если НЕ ЗначениеЗаполнено(ПроблемныйОбъект) Тогда
		
		Возврат;
		
	КонецЕсли;
	
	СравниваемыеВерсии = Новый Массив;
	СравниваемыеВерсии.Добавить(ВерсияИзДругойПрограммы);
	
	ОткрытьОтчетСравненияВерсий(ПроблемныйОбъект, СравниваемыеВерсии);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьВерсиюВЭтойПрограмме(Команда)
	
	Если НЕ ЗначениеЗаполнено(ПроблемныйОбъект)
		 Тогда
		
		Возврат;
		
	КонецЕсли;
	
	СравниваемыеВерсии = Новый Массив;
	СравниваемыеВерсии.Добавить(ВерсияЭтойПрограммы);
	
	ОткрытьОтчетСравненияВерсий(ПроблемныйОбъект, СравниваемыеВерсии);

КонецПроцедуры

&НаКлиенте
Процедура ПринятьВерсиюНепринятые(Команда)
	
	ТекстВопроса = НСтр("ru = 'Принять версию, несмотря на запрет загрузки?'", ОбщегоНазначенияКлиент.КодОсновногоЯзыка());
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПринятьВерсиюЗавершение", ЭтотОбъект);
	
	ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Нет);
	
КонецПроцедуры

&НаКлиенте
Процедура ПринятьВерсиюЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> КодВозвратаДиалога.Да Тогда
		
		Возврат;
		
	КонецЕсли;
	
	ОчиститьСообщения();
	
	СообщениеОбОшибке = "";
	ПринятьОтклонитьВерсиюНаСервере(СообщениеОбОшибке);
	
	Если ПустаяСтрока(СообщениеОбОшибке) Тогда
		
		СкрытьПредупреждение = Истина;
		ТребуетсяОбновлениеПризнакаСкрытьИзСписка = Истина;
		
	Иначе
		
		ПоказатьПредупреждение(, СообщениеОбОшибке);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьОтличия(Элемент)
	
	Если ВерсияЭтойПрограммы = 0
		ИЛИ ВерсияИзДругойПрограммы = 0 Тогда
		
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Для сравнения должно быть две версии объекта.'"), ОбщегоНазначенияКлиент.КодОсновногоЯзыка());
		Возврат;
		
	КонецЕсли;
	
	СравниваемыеВерсии = Новый Массив;
	СравниваемыеВерсии.Добавить(ВерсияЭтойПрограммы);
	СравниваемыеВерсии.Добавить(ВерсияИзДругойПрограммы);
	
	ОткрытьОтчетСравненияВерсий(ПроблемныйОбъект, СравниваемыеВерсии);
	
КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	
	ПередЗакрытиемНаСервере();
	
	Если ТребуетсяОбновлениеПризнакаСкрытьИзСписка
		ИЛИ ТребуетсяОбновлениеКомментария Тогда
		
		Закрыть(Новый Структура("ТребуетсяОбновлениеСписка", Истина));
		
	Иначе
		
		Закрыть();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ИзменитьКартинкуДекорации()
	
	Если СкрытьПредупреждение Тогда
		
		Элементы.ДекорацияКартинка.Картинка = БиблиотекаКартинок.Информация32;
		
	Иначе
		
		Элементы.ДекорацияКартинка.Картинка = БиблиотекаКартинок.Ошибка32;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьОтчетСравненияВерсий(Ссылка, СравниваемыеВерсии)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ВерсионированиеОбъектов") Тогда
		
		МодульВерсионированиеОбъектовКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ВерсионированиеОбъектовКлиент");
		МодульВерсионированиеОбъектовКлиент.ОткрытьОтчетСравненияВерсий(Ссылка, СравниваемыеВерсии);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПринятьОтклонитьВерсиюНаСервере(СообщениеОбОшибке)
	
	Если НЕ ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ВерсионированиеОбъектов") Тогда
		
		Возврат;
		
	КонецЕсли;
	
	МодульВерсионированиеОбъектов = ОбщегоНазначения.ОбщийМодуль("ВерсионированиеОбъектов");
	Попытка
		
		МодульВерсионированиеОбъектов.ПриПереходеНаВерсиюОбъекта(ПроблемныйОбъект, ВерсияИзДругойПрограммы);
		
	Исключение
		
		ПредставлениеОбъекта	= ?(ОбщегоНазначения.СсылкаСуществует(ПроблемныйОбъект), ПроблемныйОбъект, ПроблемныйОбъект.Метаданные());
		ТекстИсключения			= КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		ШаблонТекста			= НСтр("ru = 'Не удалось принять версию объекта ""%1"" по причине:%2 %3.'", ОбщегоНазначения.КодОсновногоЯзыка());
		ТекстИсключения			= СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонТекста, ПредставлениеОбъекта, Символы.ПС, ТекстИсключения);
		
		ОбщегоНазначения.СообщитьПользователю(ТекстИсключения);
		
	КонецПопытки;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗакрытиемНаСервере()
	
	Если НЕ ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ВерсионированиеОбъектов")
		ИЛИ (НЕ ТребуетсяОбновлениеПризнакаСкрытьИзСписка 
			И НЕ ТребуетсяОбновлениеКомментария) Тогда
		
		Возврат;
		
	КонецЕсли;
	
	ПараметрыЗаписиРегистра = Новый Структура;
	ПараметрыЗаписиРегистра.Вставить("Ссылка", ПроблемныйОбъект);
	ПараметрыЗаписиРегистра.Вставить("НомерВерсии", ВерсияИзДругойПрограммы);
	ПараметрыЗаписиРегистра.Вставить("ВерсияПроигнорирована", СкрытьПредупреждение);
	ПараметрыЗаписиРегистра.Вставить("Комментарий", КомментарийПредупреждения);
	
	МодульВерсионированиеОбъектов = ОбщегоНазначения.ОбщийМодуль("ВерсионированиеОбъектов");
	МодульВерсионированиеОбъектов.ИзменитьПредупреждениеСинхронизации(ПараметрыЗаписиРегистра, Истина);
	
КонецПроцедуры

#КонецОбласти
