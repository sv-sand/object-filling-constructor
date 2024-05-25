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
	
	ИдентификаторКлиента = Параметры.ИдентификаторКлиента;
	
	ПоказыватьДиалогСканера = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиСканирования/ПоказыватьДиалогСканера", 
		ИдентификаторКлиента, Истина);
	
	ИмяУстройства = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиСканирования/ИмяУстройства", 
		ИдентификаторКлиента, "");
	
	ФорматСканированногоИзображения = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиСканирования/ФорматСканированногоИзображения", 
		ИдентификаторКлиента, Перечисления.ФорматыСканированногоИзображения.PNG);
	
	ФорматХраненияОдностраничный = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиСканирования/ФорматХраненияОдностраничный", 
		ИдентификаторКлиента, Перечисления.ФорматыХраненияОдностраничныхФайлов.PNG);
	
	ФорматХраненияМногостраничный = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиСканирования/ФорматХраненияМногостраничный", 
		ИдентификаторКлиента, Перечисления.ФорматыХраненияМногостраничныхФайлов.TIF);
	
	Разрешение = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиСканирования/Разрешение", 
		ИдентификаторКлиента);
	
	Цветность = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиСканирования/Цветность", 
		ИдентификаторКлиента);
	
	Поворот = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиСканирования/Поворот", 
		ИдентификаторКлиента);
	
	РазмерБумаги = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиСканирования/РазмерБумаги", 
		ИдентификаторКлиента);
	
	ДвустороннееСканирование = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиСканирования/ДвустороннееСканирование", 
		ИдентификаторКлиента);
	
	ИспользоватьImageMagickДляПреобразованияВPDF =  ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиСканирования/ИспользоватьImageMagickДляПреобразованияВPDF", 
		ИдентификаторКлиента);
	
	КачествоJPG = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиСканирования/КачествоJPG", 
		ИдентификаторКлиента, 100);
	
	СжатиеTIFF = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиСканирования/СжатиеTIFF", 
		ИдентификаторКлиента, Перечисления.ВариантыСжатияTIFF.БезСжатия);
	
	ПутьКПрограммеКонвертации = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиСканирования/ПутьКПрограммеКонвертации", 
		ИдентификаторКлиента, "convert.exe"); // ImageMagick
	
	ФорматJPG = Перечисления.ФорматыСканированногоИзображения.JPG;
	ФорматTIF = Перечисления.ФорматыСканированногоИзображения.TIF;
	
	ФорматМногостраничныйTIF = Перечисления.ФорматыХраненияМногостраничныхФайлов.TIF;
	ФорматОдностраничныйPDF = Перечисления.ФорматыХраненияОдностраничныхФайлов.PDF;
	ФорматОдностраничныйJPG = Перечисления.ФорматыХраненияОдностраничныхФайлов.JPG;
	ФорматОдностраничныйTIF = Перечисления.ФорматыХраненияОдностраничныхФайлов.TIF;
	ФорматОдностраничныйPNG = Перечисления.ФорматыХраненияОдностраничныхФайлов.PNG;
	
	Если НЕ ИспользоватьImageMagickДляПреобразованияВPDF Тогда
		ФорматХраненияМногостраничный = ФорматМногостраничныйTIF;
	КонецЕсли;
	
	Элементы.ГруппаФорматаХранения.Видимость = ИспользоватьImageMagickДляПреобразованияВPDF;
	
	Если ИспользоватьImageMagickДляПреобразованияВPDF Тогда
		Если ФорматХраненияОдностраничный = ФорматОдностраничныйPDF Тогда
			Элементы.КачествоJPG.Видимость = (ФорматСканированногоИзображения = ФорматJPG);
			Элементы.СжатиеTIFF.Видимость = (ФорматСканированногоИзображения = ФорматTIF);
		Иначе	
			Элементы.КачествоJPG.Видимость = (ФорматХраненияОдностраничный = ФорматОдностраничныйJPG);
			Элементы.СжатиеTIFF.Видимость = (ФорматХраненияОдностраничный = ФорматОдностраничныйTIF);
		КонецЕсли;
	Иначе	
		Элементы.КачествоJPG.Видимость = (ФорматСканированногоИзображения = ФорматJPG);
		Элементы.СжатиеTIFF.Видимость = (ФорматСканированногоИзображения = ФорматTIF);
	КонецЕсли;
	
	ВидимостьДекораций = (ИспользоватьImageMagickДляПреобразованияВPDF И (ФорматХраненияОдностраничный = ФорматОдностраничныйPDF));
	Элементы.ДекорацияФорматХраненияОдностраничный.Видимость = ВидимостьДекораций;
	Элементы.ДекорацияФорматСканированногоИзображения.Видимость = ВидимостьДекораций;
	
	ВидимостьФорматаСканирования = (ИспользоватьImageMagickДляПреобразованияВPDF И (ФорматХраненияОдностраничный = ФорматОдностраничныйPDF)) ИЛИ (НЕ ИспользоватьImageMagickДляПреобразованияВPDF);
	Элементы.ГруппаФорматаСканирования.Видимость = ВидимостьФорматаСканирования;
	
	Элементы.ПутьКПрограммеКонвертации.Доступность = ИспользоватьImageMagickДляПреобразованияВPDF;
	
	Элементы.ФорматХраненияМногостраничный.Доступность = ИспользоватьImageMagickДляПреобразованияВPDF;
	
	ФорматХраненияОдностраничныйПредыдущее = ФорматХраненияОдностраничный;
	
	Если НЕ ИспользоватьImageMagickДляПреобразованияВPDF Тогда
		Элементы.ФорматСканированногоИзображения.Заголовок = НСтр("ru = 'Формат'");
	Иначе
		Элементы.ФорматСканированногоИзображения.Заголовок = НСтр("ru = 'Тип'");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбновитьСостояние();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИмяУстройстваПриИзменении(Элемент)
	ПрочитатьНастройкиСканера();
КонецПроцедуры

&НаКлиенте
Процедура ИмяУстройстваОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	Если ИмяУстройства = ВыбранноеЗначение Тогда // Ничего не изменилось - ничего не делаем.
		СтандартнаяОбработка = Ложь;
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Процедура ФорматСканированногоИзображенияПриИзменении(Элемент)
	
	Если ИспользоватьImageMagickДляПреобразованияВPDF Тогда
		Если ФорматХраненияОдностраничный = ФорматОдностраничныйPDF Тогда
			Элементы.КачествоJPG.Видимость = (ФорматСканированногоИзображения = ФорматJPG);
			Элементы.СжатиеTIFF.Видимость = (ФорматСканированногоИзображения = ФорматTIF);
		Иначе	
			Элементы.КачествоJPG.Видимость = (ФорматХраненияОдностраничный = ФорматОдностраничныйJPG);
			Элементы.СжатиеTIFF.Видимость = (ФорматХраненияОдностраничный = ФорматОдностраничныйTIF);
		КонецЕсли;
	Иначе	
		Элементы.КачествоJPG.Видимость = (ФорматСканированногоИзображения = ФорматJPG);
		Элементы.СжатиеTIFF.Видимость = (ФорматСканированногоИзображения = ФорматTIF);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПутьКПрограммеКонвертацииНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если НЕ РаботаСФайламиСлужебныйКлиент.РасширениеРаботыСФайламиПодключено() Тогда
		Возврат;
	КонецЕсли;
		
	ДиалогОткрытияФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	ДиалогОткрытияФайла.ПолноеИмяФайла = ПутьКПрограммеКонвертации;
	Фильтр = НСтр("ru = 'Исполняемые файлы(*.exe)|*.exe'");
	ДиалогОткрытияФайла.Фильтр = Фильтр;
	ДиалогОткрытияФайла.МножественныйВыбор = Ложь;
	ДиалогОткрытияФайла.Заголовок = НСтр("ru = 'Выберите файл для преобразования в PDF'");
	Если ДиалогОткрытияФайла.Выбрать() Тогда
		ПутьКПрограммеКонвертации = ДиалогОткрытияФайла.ПолноеИмяФайла;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ФорматХраненияОдностраничныйПриИзменении(Элемент)
	
	ОтработатьИзмененияФорматХраненияОдностраничный();
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьImageMagickДляПреобразованияВPDFПриИзменении(Элемент)
	
	ОтработатьИзмененияИспользоватьImageMagick();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	ОчиститьСообщения();
	Если Не ПроверитьЗаполнение() Тогда 
		Возврат;
	КонецЕсли;
	
	МассивСтруктур = Новый Массив;
	
	СистемнаяИнформация = Новый СистемнаяИнформация();
	ИдентификаторКлиента = СистемнаяИнформация.ИдентификаторКлиента;
	
	МассивСтруктур.Добавить (СформироватьНастройку("ПоказыватьДиалогСканера", ПоказыватьДиалогСканера, ИдентификаторКлиента));
	МассивСтруктур.Добавить (СформироватьНастройку("ИмяУстройства", ИмяУстройства, ИдентификаторКлиента));
	
	МассивСтруктур.Добавить (СформироватьНастройку("ФорматСканированногоИзображения", ФорматСканированногоИзображения, ИдентификаторКлиента));
	МассивСтруктур.Добавить (СформироватьНастройку("ФорматХраненияОдностраничный", ФорматХраненияОдностраничный, ИдентификаторКлиента));
	МассивСтруктур.Добавить (СформироватьНастройку("ФорматХраненияМногостраничный", ФорматХраненияМногостраничный, ИдентификаторКлиента));
	МассивСтруктур.Добавить (СформироватьНастройку("Разрешение", Разрешение, ИдентификаторКлиента));
	МассивСтруктур.Добавить (СформироватьНастройку("Цветность", Цветность, ИдентификаторКлиента));
	МассивСтруктур.Добавить (СформироватьНастройку("Поворот", Поворот, ИдентификаторКлиента));
	МассивСтруктур.Добавить (СформироватьНастройку("РазмерБумаги", РазмерБумаги, ИдентификаторКлиента));
	МассивСтруктур.Добавить (СформироватьНастройку("ДвустороннееСканирование", ДвустороннееСканирование, ИдентификаторКлиента));
	МассивСтруктур.Добавить (СформироватьНастройку("ИспользоватьImageMagickДляПреобразованияВPDF", ИспользоватьImageMagickДляПреобразованияВPDF, ИдентификаторКлиента));
	МассивСтруктур.Добавить (СформироватьНастройку("КачествоJPG", КачествоJPG, ИдентификаторКлиента));
	МассивСтруктур.Добавить (СформироватьНастройку("СжатиеTIFF", СжатиеTIFF, ИдентификаторКлиента));
	МассивСтруктур.Добавить (СформироватьНастройку("ПутьКПрограммеКонвертации", ПутьКПрограммеКонвертации, ИдентификаторКлиента));
	
	ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекСохранитьМассив(МассивСтруктур, Истина);
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтандартныеНастройки(Команда)
	ПрочитатьНастройкиСканера();
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьНомераОтсканированныхФайлов(Команда)
	ОткрытьФорму("РегистрСведений.НомераОтсканированныхФайлов.ФормаСписка");
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Функция СформироватьНастройку(Имя, Значение, ИдентификаторКлиента)
	
	Элемент = Новый Структура;
	Элемент.Вставить("Объект", "НастройкиСканирования/" + Имя);
	Элемент.Вставить("Настройка", ИдентификаторКлиента);
	Элемент.Вставить("Значение", Значение);
	Возврат Элемент;
	
КонецФункции	

&НаКлиенте
Процедура ОбновитьСостояние()
	
	Элементы.ИмяУстройства.Доступность = Ложь;
	Элементы.ИмяУстройства.СписокВыбора.Очистить();
	Элементы.ИмяУстройства.РежимВыбораИзСписка = Ложь;
	Элементы.ФорматСканированногоИзображения.Доступность = Ложь;
	Элементы.Разрешение.Доступность = Ложь;
	Элементы.Цветность.Доступность = Ложь;
	Элементы.Поворот.Доступность = Ложь;
	Элементы.РазмерБумаги.Доступность = Ложь;
	Элементы.ДвустороннееСканирование.Доступность = Ложь;
	Элементы.УстановитьСтандартныеНастройки.Доступность = Ложь;
	
	Если Не РаботаСФайламиСлужебныйКлиент.ПроинициализироватьКомпоненту() Тогда
		Элементы.ИмяУстройства.Доступность = Ложь;
		Возврат;
	КонецЕсли;
		
	Если Не РаботаСФайламиСлужебныйКлиент.ДоступнаКомандаСканировать() Тогда
		Элементы.ИмяУстройства.Доступность = Ложь;
		Возврат;
	КонецЕсли;
		
	МассивУстройств = РаботаСФайламиСлужебныйКлиент.ПолучитьУстройства();
	Для Каждого Строка Из МассивУстройств Цикл
		Элементы.ИмяУстройства.СписокВыбора.Добавить(Строка);
	КонецЦикла;
	Элементы.ИмяУстройства.Доступность = Истина;
	Элементы.ИмяУстройства.РежимВыбораИзСписка = Истина;
	
	Если ПустаяСтрока(ИмяУстройства) Тогда
		Возврат;
	КонецЕсли;
	
	Элементы.ФорматСканированногоИзображения.Доступность = Истина;
	Элементы.Разрешение.Доступность = Истина;
	Элементы.Цветность.Доступность = Истина;
	Элементы.УстановитьСтандартныеНастройки.Доступность = Истина;
	
	ДвустороннееСканированиеЧисло = РаботаСФайламиСлужебныйКлиент.ПолучитьНастройку(
		ИмяУстройства, "DUPLEX");
	
	Элементы.ДвустороннееСканирование.Доступность = (ДвустороннееСканированиеЧисло <> -1);
	
	Если Не Разрешение.Пустая() И Не Цветность.Пустая() Тогда
		Элементы.Поворот.Доступность = Не Поворот.Пустая();
		Элементы.РазмерБумаги.Доступность = Не РазмерБумаги.Пустая();
		Возврат;
	КонецЕсли;
	
	РазрешениеЧисло = РаботаСФайламиСлужебныйКлиент.ПолучитьНастройку(ИмяУстройства, "XRESOLUTION");
	ЦветностьЧисло  = РаботаСФайламиСлужебныйКлиент.ПолучитьНастройку(ИмяУстройства, "PIXELTYPE");
	ПоворотЧисло = РаботаСФайламиСлужебныйКлиент.ПолучитьНастройку(ИмяУстройства, "ROTATION");
	РазмерБумагиЧисло  = РаботаСФайламиСлужебныйКлиент.ПолучитьНастройку(ИмяУстройства, "SUPPORTEDSIZES");
	
	Элементы.Поворот.Доступность = (ПоворотЧисло <> -1);
	Элементы.РазмерБумаги.Доступность = (РазмерБумагиЧисло <> -1);
	
	ДвустороннееСканирование = ? ((ДвустороннееСканированиеЧисло = 1), Истина, Ложь);
	СохранитьВНастройкахПараметрыСканера(РазрешениеЧисло, ЦветностьЧисло, ПоворотЧисло, РазмерБумагиЧисло);
	
КонецПроцедуры

&НаСервере
Процедура СохранитьВНастройкахПараметрыСканера(РазрешениеЧисло, ЦветностьЧисло, ПоворотЧисло, РазмерБумагиЧисло) 
	
	ПреобразоватьПараметрыСканераВПеречисления(РазрешениеЧисло, ЦветностьЧисло, ПоворотЧисло, РазмерБумагиЧисло);
			
	МассивСтруктур = Новый Массив;
	
	СистемнаяИнформация = Новый СистемнаяИнформация();
	ИдентификаторКлиента = СистемнаяИнформация.ИдентификаторКлиента;
	
	Элемент = Новый Структура;
	Элемент.Вставить("Объект", "НастройкиСканирования/Разрешение");
	Элемент.Вставить("Настройка", ИдентификаторКлиента);
	Элемент.Вставить("Значение", Разрешение);
	МассивСтруктур.Добавить(Элемент);
	
	Элемент = Новый Структура;
	Элемент.Вставить("Объект", "НастройкиСканирования/Цветность");
	Элемент.Вставить("Настройка", ИдентификаторКлиента);
	Элемент.Вставить("Значение", Цветность);
	МассивСтруктур.Добавить(Элемент);
	
	Элемент = Новый Структура;
	Элемент.Вставить("Объект", "НастройкиСканирования/Поворот");
	Элемент.Вставить("Настройка", ИдентификаторКлиента);
	Элемент.Вставить("Значение", Поворот);
	МассивСтруктур.Добавить(Элемент);
	
	Элемент = Новый Структура;
	Элемент.Вставить("Объект", "НастройкиСканирования/РазмерБумаги");
	Элемент.Вставить("Настройка", ИдентификаторКлиента);
	Элемент.Вставить("Значение", РазмерБумаги);
	МассивСтруктур.Добавить(Элемент);
	
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранитьМассив(МассивСтруктур);
	
КонецПроцедуры

&НаКлиенте
Процедура ПрочитатьНастройкиСканера()
	
	Элементы.ФорматСканированногоИзображения.Доступность = Не ПустаяСтрока(ИмяУстройства);
	Элементы.Разрешение.Доступность = Не ПустаяСтрока(ИмяУстройства);
	Элементы.Цветность.Доступность = Не ПустаяСтрока(ИмяУстройства);
	Элементы.ДвустороннееСканирование.Доступность = Ложь;
	Элементы.УстановитьСтандартныеНастройки.Доступность = Не ПустаяСтрока(ИмяУстройства);
	
	Если ПустаяСтрока(ИмяУстройства) Тогда
		Элементы.Поворот.Доступность = Ложь;
		Элементы.РазмерБумаги.Доступность = Ложь;
		Возврат;
	КонецЕсли;
	
	РазрешениеЧисло = РаботаСФайламиСлужебныйКлиент.ПолучитьНастройку(
		ИмяУстройства, "XRESOLUTION");
	
	ЦветностьЧисло = РаботаСФайламиСлужебныйКлиент.ПолучитьНастройку(
		ИмяУстройства, "PIXELTYPE");
	
	ПоворотЧисло = РаботаСФайламиСлужебныйКлиент.ПолучитьНастройку(
		ИмяУстройства, "ROTATION");
	
	РазмерБумагиЧисло = РаботаСФайламиСлужебныйКлиент.ПолучитьНастройку(
		ИмяУстройства, "SUPPORTEDSIZES");
	
	ДвустороннееСканированиеЧисло = РаботаСФайламиСлужебныйКлиент.ПолучитьНастройку(
		ИмяУстройства, "DUPLEX");
	
	Элементы.Поворот.Доступность = (ПоворотЧисло <> -1);
	Элементы.РазмерБумаги.Доступность = (РазмерБумагиЧисло <> -1);
	
	Элементы.ДвустороннееСканирование.Доступность = (ДвустороннееСканированиеЧисло <> -1);
	ДвустороннееСканирование = ? ((ДвустороннееСканированиеЧисло = 1), Истина, Ложь);
	
	ПреобразоватьПараметрыСканераВПеречисления(
		РазрешениеЧисло, ЦветностьЧисло, ПоворотЧисло, РазмерБумагиЧисло);
		
КонецПроцедуры

&НаСервере
Процедура ПреобразоватьПараметрыСканераВПеречисления(РазрешениеЧисло, ЦветностьЧисло, ПоворотЧисло, РазмерБумагиЧисло) 
	
	Результат = РаботаСФайламиСлужебный.ПараметрыСканераВПеречисления(РазрешениеЧисло, ЦветностьЧисло, ПоворотЧисло, РазмерБумагиЧисло);
	Разрешение = Результат.Разрешение;
	Цветность = Результат.Цветность;
	Поворот = Результат.Поворот;
	РазмерБумаги = Результат.РазмерБумаги;
	
КонецПроцедуры

&НаСервере
Функция ПреобразоватьФорматСканированияВФорматХранения(ФорматСканирования)
	
	Если ФорматСканирования = Перечисления.ФорматыСканированногоИзображения.BMP Тогда
		Возврат Перечисления.ФорматыХраненияОдностраничныхФайлов.BMP;
	ИначеЕсли ФорматСканирования = Перечисления.ФорматыСканированногоИзображения.GIF Тогда
		Возврат Перечисления.ФорматыХраненияОдностраничныхФайлов.GIF;
	ИначеЕсли ФорматСканирования = Перечисления.ФорматыСканированногоИзображения.JPG Тогда
		Возврат Перечисления.ФорматыХраненияОдностраничныхФайлов.JPG;
	ИначеЕсли ФорматСканирования = Перечисления.ФорматыСканированногоИзображения.PNG Тогда
		Возврат Перечисления.ФорматыХраненияОдностраничныхФайлов.PNG; 
	ИначеЕсли ФорматСканирования = Перечисления.ФорматыСканированногоИзображения.TIF Тогда
		Возврат Перечисления.ФорматыХраненияОдностраничныхФайлов.TIF;
	КонецЕсли;
	
	Возврат Перечисления.ФорматыХраненияОдностраничныхФайлов.PNG; 
	
КонецФункции	

&НаСервере
Функция ПреобразоватьФорматХраненияВФорматСканирования(ФорматХранения)
	
	Если ФорматХранения = Перечисления.ФорматыХраненияОдностраничныхФайлов.BMP Тогда
		Возврат Перечисления.ФорматыСканированногоИзображения.BMP;
	ИначеЕсли ФорматХранения = Перечисления.ФорматыХраненияОдностраничныхФайлов.GIF Тогда
		Возврат Перечисления.ФорматыСканированногоИзображения.GIF;
	ИначеЕсли ФорматХранения = Перечисления.ФорматыХраненияОдностраничныхФайлов.JPG Тогда
		Возврат Перечисления.ФорматыСканированногоИзображения.JPG;
	ИначеЕсли ФорматХранения = Перечисления.ФорматыХраненияОдностраничныхФайлов.PNG Тогда
		Возврат Перечисления.ФорматыСканированногоИзображения.PNG; 
	ИначеЕсли ФорматХранения = Перечисления.ФорматыХраненияОдностраничныхФайлов.TIF Тогда
		Возврат Перечисления.ФорматыСканированногоИзображения.TIF;
	КонецЕсли;
	
	Возврат ФорматСканированногоИзображения; 
	
КонецФункции	

&НаСервере
Процедура ОтработатьИзмененияИспользоватьImageMagick()
	
	Если НЕ ИспользоватьImageMagickДляПреобразованияВPDF Тогда
		ФорматХраненияМногостраничный = ФорматМногостраничныйTIF;
		ФорматСканированногоИзображения = ПреобразоватьФорматХраненияВФорматСканирования(ФорматХраненияОдностраничный);
		Элементы.ФорматСканированногоИзображения.Заголовок = НСтр("ru = 'Формат'");
	Иначе
		ФорматХраненияОдностраничный = ПреобразоватьФорматСканированияВФорматХранения(ФорматСканированногоИзображения);
		Элементы.ФорматСканированногоИзображения.Заголовок = НСтр("ru = 'Тип'");
	КонецЕсли;	
	
	ВидимостьДекораций = (ИспользоватьImageMagickДляПреобразованияВPDF И (ФорматХраненияОдностраничный = ФорматОдностраничныйPDF));
	Элементы.ДекорацияФорматХраненияОдностраничный.Видимость = ВидимостьДекораций;
	Элементы.ДекорацияФорматСканированногоИзображения.Видимость = ВидимостьДекораций;
	
	ВидимостьФорматаСканирования = (ИспользоватьImageMagickДляПреобразованияВPDF И (ФорматХраненияОдностраничный = ФорматОдностраничныйPDF)) ИЛИ (НЕ ИспользоватьImageMagickДляПреобразованияВPDF);
	Элементы.ГруппаФорматаСканирования.Видимость = ВидимостьФорматаСканирования;
	
	Элементы.ПутьКПрограммеКонвертации.Доступность = ИспользоватьImageMagickДляПреобразованияВPDF;
	Элементы.ФорматХраненияМногостраничный.Доступность = ИспользоватьImageMagickДляПреобразованияВPDF;
	Элементы.ГруппаФорматаХранения.Видимость = ИспользоватьImageMagickДляПреобразованияВPDF;	
	
КонецПроцедуры

&НаСервере
Процедура ОтработатьИзмененияФорматХраненияОдностраничный()
	
	Элементы.ГруппаФорматаСканирования.Видимость = (ФорматХраненияОдностраничный = ФорматОдностраничныйPDF);
	
	Если ФорматХраненияОдностраничный = ФорматОдностраничныйPDF Тогда
		ФорматСканированногоИзображения = ПреобразоватьФорматХраненияВФорматСканирования(ФорматХраненияОдностраничныйПредыдущее);
	КонецЕсли;	
	
	ВидимостьДекораций = (ИспользоватьImageMagickДляПреобразованияВPDF И (ФорматХраненияОдностраничный = ФорматОдностраничныйPDF));
	Элементы.ДекорацияФорматХраненияОдностраничный.Видимость = ВидимостьДекораций;
	Элементы.ДекорацияФорматСканированногоИзображения.Видимость = ВидимостьДекораций;
	
	Если ИспользоватьImageMagickДляПреобразованияВPDF Тогда
		Если ФорматХраненияОдностраничный = ФорматОдностраничныйPDF Тогда
			Элементы.КачествоJPG.Видимость = (ФорматСканированногоИзображения = ФорматJPG);
			Элементы.СжатиеTIFF.Видимость = (ФорматСканированногоИзображения = ФорматTIF);
		Иначе	
			Элементы.КачествоJPG.Видимость = (ФорматХраненияОдностраничный = ФорматОдностраничныйJPG);
			Элементы.СжатиеTIFF.Видимость = (ФорматХраненияОдностраничный = ФорматОдностраничныйTIF);
		КонецЕсли;
	Иначе	
		Элементы.КачествоJPG.Видимость = (ФорматСканированногоИзображения = ФорматJPG);
		Элементы.СжатиеTIFF.Видимость = (ФорматСканированногоИзображения = ФорматTIF);
	КонецЕсли;
	
	ФорматХраненияОдностраничныйПредыдущее = ФорматХраненияОдностраничный;
	
КонецПроцедуры

#КонецОбласти
