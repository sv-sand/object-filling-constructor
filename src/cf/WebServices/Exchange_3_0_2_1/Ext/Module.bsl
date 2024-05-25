﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

////////////////////////////////////////////////////////////////////////////////
// Обработчики операций

// Соответствует операции Upload.
Функция ВыполнитьВыгрузку(ИмяПланаОбмена, КодУзлаИнформационнойБазы, ХранилищеСообщенияОбмена, ОбластьДанных)
	
	ВойтиВОбластьДанных(ОбластьДанных);
	
	ПроверитьБлокировкуИнформационнойБазыДляОбновления();
	
	ОбменДаннымиСервер.ПроверитьИспользованиеОбменаДанными();
	
	УстановитьПривилегированныйРежим(Истина);
	
	СообщениеОбмена = "";
	
	ОбменДаннымиСервер.ВыполнитьВыгрузкуДляУзлаИнформационнойБазыЧерезСтроку(ИмяПланаОбмена, КодУзлаИнформационнойБазы, СообщениеОбмена);
	
	ХранилищеСообщенияОбмена = Новый ХранилищеЗначения(СообщениеОбмена, Новый СжатиеДанных(9));
	
	ВыйтиИзОбластиДанных(ОбластьДанных);
	
	Возврат "";
	
КонецФункции

// Соответствует операции UploadData.
Функция ВыполнитьВыгрузкуДанных(ИмяПланаОбмена,
								КодУзлаИнформационнойБазы,
								ИдентификаторФайлаСтрокой,
								ДлительнаяОперация,
								ИдентификаторОперации,
								ДлительнаяОперацияРазрешена,
								ОбластьДанных)
								
	ВойтиВОбластьДанных(ОбластьДанных);								
								
	ПроверитьБлокировкуИнформационнойБазыДляОбновления();
	
	ОбменДаннымиСервер.ПроверитьИспользованиеОбменаДанными();
	
	ИдентификаторФайла = Новый УникальныйИдентификатор;
	ИдентификаторФайлаСтрокой = Строка(ИдентификаторФайла);
	
	ВыполнитьВыгрузкуДанныхВКлиентСерверномРежиме(ИмяПланаОбмена, КодУзлаИнформационнойБазы, ИдентификаторФайла, ДлительнаяОперация, ИдентификаторОперации, ДлительнаяОперацияРазрешена);
	
	ВыйтиИзОбластиДанных(ОбластьДанных);
	
	Возврат "";
	
КонецФункции

// Соответствует операции UploadDataInt.
Функция ВыполнитьВыгрузкуДанныхВнутренняяПубликация(ИмяПланаОбмена,
													КодУзлаИнформационнойБазы,
													ИдентификаторЗадачи,
													ОбластьДанных)
														
	УстановитьПривилегированныйРежим(Истина);
	
	ПроверитьБлокировкуИнформационнойБазыДляОбновления();
	
	ОбменДаннымиСервер.ПроверитьИспользованиеОбменаДанными();
		
	ВыполнитьВыгрузкуДанныхВКлиентСерверномРежимеВнутренняяПубликация(
		ИмяПланаОбмена, КодУзлаИнформационнойБазы, ИдентификаторЗадачи, ОбластьДанных);
		
	Возврат "";
	
КонецФункции

// Соответствует операции Download.
Функция ВыполнитьЗагрузку(ИмяПланаОбмена, КодУзлаИнформационнойБазы, ХранилищеСообщенияОбмена, ОбластьДанных)
	
	ВойтиВОбластьДанных(ОбластьДанных);
	
	ПроверитьБлокировкуИнформационнойБазыДляОбновления();
	
	ОбменДаннымиСервер.ПроверитьИспользованиеОбменаДанными();
	
	УстановитьПривилегированныйРежим(Истина);
	
	ОбменДаннымиСервер.ВыполнитьЗагрузкуДляУзлаИнформационнойБазыЧерезСтроку(ИмяПланаОбмена, КодУзлаИнформационнойБазы, ХранилищеСообщенияОбмена.Получить());
	
	ВыйтиИзОбластиДанных(ОбластьДанных);
	
	Возврат "";
	
КонецФункции

// Соответствует операции DownloadData.
Функция ВыполнитьЗагрузкуДанных(ИмяПланаОбмена,
								КодУзлаИнформационнойБазы,
								ИдентификаторФайлаСтрокой,
								ДлительнаяОперация,
								ИдентификаторОперации,
								ДлительнаяОперацияРазрешена,
								ОбластьДанных)
								
	ВойтиВОбластьДанных(ОбластьДанных);
	
	ПроверитьБлокировкуИнформационнойБазыДляОбновления();
	
	ОбменДаннымиСервер.ПроверитьИспользованиеОбменаДанными();
	
	ИдентификаторФайла = Новый УникальныйИдентификатор(ИдентификаторФайлаСтрокой);
	
	ВыполнитьЗагрузкуДанныхВКлиентСерверномРежиме(ИмяПланаОбмена, КодУзлаИнформационнойБазы, ИдентификаторФайла, ДлительнаяОперация, ИдентификаторОперации, ДлительнаяОперацияРазрешена);	
	
	ВыйтиИзОбластиДанных(ОбластьДанных);
	
	Возврат "";
	
КонецФункции

// Соответствует операции DownloadDataInt.
Функция ВыполнитьЗагрузкуДанныхВнутренняяПубликация(ИмяПланаОбмена,
													КодУзлаИнформационнойБазы,
													ИдентификаторЗадачи,
													ИдентификаторФайлаСтрокой,
													ОбластьДанных)
													
	УстановитьПривилегированныйРежим(Истина);
	
	ПроверитьБлокировкуИнформационнойБазыДляОбновления();
	
	ОбменДаннымиСервер.ПроверитьИспользованиеОбменаДанными();
	
	ИдентификаторФайла = Новый УникальныйИдентификатор(ИдентификаторФайлаСтрокой);
	
	ВыполнитьЗагрузкуДанныхВКлиентСерверномРежимеВнутренняяПубликация(
		ИмяПланаОбмена,	КодУзлаИнформационнойБазы, ИдентификаторЗадачи, ИдентификаторФайла, ОбластьДанных);	

	Возврат "";
	
КонецФункции

// Соответствует операции GetIBParameters.
Функция ПолучитьПараметрыИнформационнойБазы(ИмяПланаОбмена, КодУзла, СообщениеОбОшибке, ОбластьДанных)
	
	ВойтиВОбластьДанных(ОбластьДанных);
	
	Результат = ОбменДаннымиСервер.ПараметрыИнформационнойБазы(ИмяПланаОбмена, КодУзла, СообщениеОбОшибке);
	
	ВыйтиИзОбластиДанных(ОбластьДанных);
	
	Возврат СериализаторXDTO.ЗаписатьXDTO(Результат);
	
КонецФункции

// Соответствует операции CreateExchangeNode.
Функция СоздатьУзелОбменаДанными(ПараметрыXDTO, ОбластьДанных)
	
	ВойтиВОбластьДанных(ОбластьДанных);
	
	УстановитьПривилегированныйРежим(Истина);
	  	
	ОбменДаннымиСервер.ПроверитьИспользованиеОбменаДанными(Истина);
	
	Параметры = СериализаторXDTO.ПрочитатьXDTO(ПараметрыXDTO);
	
	НастройкиПодключения = Параметры.НастройкиПодключения;
	
	МодульПомощникНастройки = ОбменДаннымиСервер.МодульПомощникСозданияОбменаДанными();
	Попытка
		МодульПомощникНастройки.ЗаполнитьНастройкиПодключенияИзXML(
			НастройкиПодключения, Параметры.СтрокаПараметровXML, , Истина);
			
		Если ЗначениеЗаполнено(НастройкиПодключения.WSКонечнаяТочкаКорреспондента) Тогда
			НастройкиПодключения.WSКонечнаяТочкаКорреспондента = 
				ПланыОбмена["ОбменСообщениями"].НайтиПоКоду(НастройкиПодключения.WSКонечнаяТочкаКорреспондента);
			НастройкиПодключения.Вставить("ВидТранспортаСообщенийОбмена", Перечисления.ВидыТранспортаСообщенийОбмена.WS);	
		Иначе	
			НастройкиПодключения.Вставить("ВидТранспортаСообщенийОбмена", Перечисления.ВидыТранспортаСообщенийОбмена.WSПассивныйРежим);
		КонецЕсли;
			
		МодульПомощникНастройки.ВыполнитьДействияПоНастройкеОбменаДанными(
			НастройкиПодключения);
	Исключение
		СообщениеОбОшибке = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			
		ЗаписьЖурналаРегистрации(ОбменДаннымиСервер.СобытиеЖурналаРегистрацииСозданиеОбменаДанными(),
			УровеньЖурналаРегистрации.Ошибка, , , СообщениеОбОшибке);
			
		ВызватьИсключение СообщениеОбОшибке;
	КонецПопытки;
	
	ВыйтиИзОбластиДанных(ОбластьДанных);
	
	Возврат "";
	
КонецФункции

// Соответствует операции RemoveExchangeNode.
Функция УдалитьУзелОбменаДанными(ИмяПланаОбмена, ИдентификаторУзла, ОбластьДанных)
	
	ВойтиВОбластьДанных(ОбластьДанных);
	
	УстановитьПривилегированныйРежим(Истина);
		
	УзелОбмена = ОбменДаннымиСервер.УзелПланаОбменаПоКоду(ИмяПланаОбмена, ИдентификаторУзла);
		
	Если УзелОбмена = Неопределено Тогда
		ПредставлениеПрограммы = ?(ОбщегоНазначения.РазделениеВключено(),
			Метаданные.Синоним, ОбменДаннымиПовтИсп.ИмяЭтойИнформационнойБазы());
			
		ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'В ""%1"" не найден узел плана обмена ""%2"" с идентификатором ""%3"".'"),
			ПредставлениеПрограммы, ИмяПланаОбмена, ИдентификаторУзла);
	КонецЕсли;
	
	ОбменДаннымиСервер.УдалитьНастройкуСинхронизации(УзелОбмена);
	
	ВыйтиИзОбластиДанных(ОбластьДанных);
	
	Возврат "";
	
КонецФункции

// Соответствует операции GetContinuousOperationStatus.
Функция ПолучитьСостояниеДлительнойОперации(ИдентификаторОперации, СтрокаСообщенияОбОшибке, ОбластьДанных)
	
	ВойтиВОбластьДанных(ОбластьДанных);
	
	УстановитьПривилегированныйРежим(Истина);
		
	СостоянияФоновогоЗадания = Новый Соответствие;
	СостоянияФоновогоЗадания.Вставить(СостояниеФоновогоЗадания.Активно,           "Active");
	СостоянияФоновогоЗадания.Вставить(СостояниеФоновогоЗадания.Завершено,         "Completed");
	СостоянияФоновогоЗадания.Вставить(СостояниеФоновогоЗадания.ЗавершеноАварийно, "Failed");
	СостоянияФоновогоЗадания.Вставить(СостояниеФоновогоЗадания.Отменено,          "Canceled");
		
	ФоновоеЗадание = ФоновыеЗадания.НайтиПоУникальномуИдентификатору(Новый УникальныйИдентификатор(ИдентификаторОперации));
	
	Если ФоновоеЗадание = Неопределено Тогда
		
		СтрокаСообщенияОбОшибке = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Не найдено длительной операции с идентификатором %1.'"),
			ИдентификаторОперации);
			
		ВыйтиИзОбластиДанных(ОбластьДанных);
		
		Возврат СостоянияФоновогоЗадания.Получить(СостояниеФоновогоЗадания.Отменено);
		
	КонецЕсли;
	
	Если ФоновоеЗадание.ИнформацияОбОшибке <> Неопределено Тогда
		
		СтрокаСообщенияОбОшибке = ПодробноеПредставлениеОшибки(ФоновоеЗадание.ИнформацияОбОшибке);
		
	КонецЕсли;
	
	ВыйтиИзОбластиДанных(ОбластьДанных);
	
	Возврат СостоянияФоновогоЗадания.Получить(ФоновоеЗадание.Состояние);
	
КонецФункции

// Соответствует операции PrepareGetFile.
Функция PrepareGetFile(FileId, BlockSize, TransferId, PartQuantity, Zone)
	
	ВойтиВОбластьДанных(Zone);
	
	УстановитьПривилегированныйРежим(Истина);
	
	TransferId = Новый УникальныйИдентификатор;
	
	ИмяИсходногоФайла = ОбменДаннымиСервер.ПолучитьФайлИзХранилища(FileId);
	
	ВременныйКаталог = ВременныйКаталогВыгрузки(TransferId);
	
	ИмяИсходногоФайлаВоВременномКаталоге = ОбщегоНазначенияКлиентСервер.ПолучитьПолноеИмяФайла(ВременныйКаталог, "data.zip");
	
	СоздатьКаталог(ВременныйКаталог);
	
	ПереместитьФайл(ИмяИсходногоФайла, ИмяИсходногоФайлаВоВременномКаталоге);
	
	Если BlockSize <> 0 Тогда
		// Разделение файла на части
		ИменаФайлов = РазделитьФайл(ИмяИсходногоФайлаВоВременномКаталоге, BlockSize * 1024);
		PartQuantity = ИменаФайлов.Количество();
		
		УдалитьФайлы(ИмяИсходногоФайлаВоВременномКаталоге);
	Иначе
		PartQuantity = 1;
		ПереместитьФайл(ИмяИсходногоФайлаВоВременномКаталоге, ИмяИсходногоФайлаВоВременномКаталоге + ".1");
	КонецЕсли;
	
	ВыйтиИзОбластиДанных(Zone);
		
	Возврат "";
	
КонецФункции

// Соответствует операции GetFilePart.
Функция GetFilePart(TransferId, PartNumber, PartData, Zone)
	
	ВойтиВОбластьДанных(Zone);
	
	ИменаФайлов = НайтиФайлЧасти(ВременныйКаталогВыгрузки(TransferId), PartNumber);
	
	Если ИменаФайлов.Количество() = 0 Тогда
		
		ШаблонСообщения = НСтр("ru = 'Не найден фрагмент %1 сессии передачи с идентификатором %2'");
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, Строка(PartNumber), Строка(TransferId));
		ВызватьИсключение(ТекстСообщения);
		
	ИначеЕсли ИменаФайлов.Количество() > 1 Тогда
		
		ШаблонСообщения = НСтр("ru = 'Найдено несколько фрагментов %1 сессии передачи с идентификатором %2'");
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, Строка(PartNumber), Строка(TransferId));
		ВызватьИсключение(ТекстСообщения);
		
	КонецЕсли;
	
	ИмяФайлаЧасти = ИменаФайлов[0].ПолноеИмя;
	PartData = Новый ДвоичныеДанные(ИмяФайлаЧасти);
	
	ВыйтиИзОбластиДанных(Zone);
	
	Возврат "";
	
КонецФункции

// Соответствует операции ReleaseFile.
Функция ReleaseFile(TransferId)
	
	Попытка
		УдалитьФайлы(ВременныйКаталогВыгрузки(TransferId));
	Исключение
		ЗаписьЖурналаРегистрации(ОбменДаннымиСервер.СобытиеЖурналаРегистрацииУдалениеВременногоФайла(),
			УровеньЖурналаРегистрации.Ошибка,,, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
	Возврат "";
	
КонецФункции

// Соответствует операции PutFilePart.
//
// Параметры:
//   TransferId - УникальныйИдентификатор - уникальный идентификатор сессии передачи данных.
//   PartNumber - Число - номер части файла.
//   PartData - ДвоичныеДанные - данные части файла.
//
Функция PutFilePart(TransferId, PartNumber, PartData, Zone)
	
	ВойтиВОбластьДанных(Zone);
	
	ВременныйКаталог = ВременныйКаталогВыгрузки(TransferId);
	
	Если PartNumber = 1 Тогда
		
		СоздатьКаталог(ВременныйКаталог);
		
	КонецЕсли;
	
	ИмяФайла = ОбщегоНазначенияКлиентСервер.ПолучитьПолноеИмяФайла(ВременныйКаталог, ПолучитьИмяФайлаЧасти(PartNumber));
	
	PartData.Записать(ИмяФайла);
	
	ВыйтиИзОбластиДанных(Zone);
	
	Возврат "";
	
КонецФункции

// Соответствует операции SaveFileFromParts.
Функция SaveFileFromParts(TransferId, PartQuantity, FileId, Zone)
	
	ВойтиВОбластьДанных(Zone);
	
	УстановитьПривилегированныйРежим(Истина);
	
	ВременныйКаталог = ВременныйКаталогВыгрузки(TransferId);
	
	ФайлыЧастейДляОбъединения = Новый Массив;
	
	Для НомерЧасти = 1 По PartQuantity Цикл
		
		ИмяФайла = ОбщегоНазначенияКлиентСервер.ПолучитьПолноеИмяФайла(ВременныйКаталог, ПолучитьИмяФайлаЧасти(НомерЧасти));
		
		Если НайтиФайлы(ИмяФайла).Количество() = 0 Тогда
			ШаблонСообщения = НСтр("ru = 'Не найден фрагмент %1 сессии передачи с идентификатором %2.
					|Необходимо убедиться, что в настройках программы заданы параметры
					|""Каталог временных файлов для Linux"" и ""Каталог временных файлов для Windows"".'");
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, Строка(НомерЧасти), Строка(TransferId));
			ВызватьИсключение(ТекстСообщения);
		КонецЕсли;
		
		ФайлыЧастейДляОбъединения.Добавить(ИмяФайла);
		
	КонецЦикла;
	
	ИмяАрхива = ОбщегоНазначенияКлиентСервер.ПолучитьПолноеИмяФайла(ВременныйКаталог, "data.zip");
	
	ОбъединитьФайлы(ФайлыЧастейДляОбъединения, ИмяАрхива);
	
	Разархиватор = Новый ЧтениеZipФайла(ИмяАрхива);
	
	Если Разархиватор.Элементы.Количество() = 0 Тогда
		
		Попытка
			УдалитьФайлы(ВременныйКаталог);
		Исключение
			ЗаписьЖурналаРегистрации(ОбменДаннымиСервер.СобытиеЖурналаРегистрацииУдалениеВременногоФайла(),
				УровеньЖурналаРегистрации.Ошибка,,, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));	
		КонецПопытки;
		
		ВыйтиИзОбластиДанных(Zone);
		ВызватьИсключение(НСтр("ru = 'Файл архива не содержит данных.'"));
		
	КонецЕсли;
	
	КаталогВыгрузки = ОбменДаннымиСервер.КаталогВременногоХранилищаФайлов();
	
	ЭлементАрхива = Разархиватор.Элементы.Получить(0);
	ИмяФайла = ОбщегоНазначенияКлиентСервер.ПолучитьПолноеИмяФайла(КаталогВыгрузки, ЭлементАрхива.Имя);
	
	Разархиватор.Извлечь(ЭлементАрхива, КаталогВыгрузки);
	Разархиватор.Закрыть();
	
	FileId = ОбменДаннымиСервер.ПоместитьФайлВХранилище(ИмяФайла, FileId);
	
	Попытка
		УдалитьФайлы(ВременныйКаталог);
	Исключение
		ЗаписьЖурналаРегистрации(ОбменДаннымиСервер.СобытиеЖурналаРегистрацииУдалениеВременногоФайла(),
			УровеньЖурналаРегистрации.Ошибка,,, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));	
	КонецПопытки;	
	
	ВыйтиИзОбластиДанных(Zone);
	
	Возврат "";
	
КонецФункции

// Соответствует операции PutMessageForDataMatching.
Функция PutMessageForDataMatching(ИмяПланаОбмена, ИдентификаторУзла, ИдентификаторФайла, ОбластьДанных)
	
	ВойтиВОбластьДанных(ОбластьДанных);
	
	УзелОбмена = ОбменДаннымиСервер.УзелПланаОбменаПоКоду(ИмяПланаОбмена, ИдентификаторУзла);
		
	Если УзелОбмена = Неопределено Тогда
		
		ПредставлениеПрограммы = ?(ОбщегоНазначения.РазделениеВключено(),
			Метаданные.Синоним, ОбменДаннымиПовтИсп.ИмяЭтойИнформационнойБазы());
			
		ВыйтиИзОбластиДанных(ОбластьДанных);	
			
		ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'В ""%1"" не найден узел плана обмена ""%2"" с идентификатором ""%3"".'"),
			ПредставлениеПрограммы, ИмяПланаОбмена, ИдентификаторУзла);
			
	КонецЕсли;
	
	ПроверитьБлокировкуИнформационнойБазыДляОбновления();
	
	ОбменДаннымиСервер.ПроверитьИспользованиеОбменаДанными();
	
	ОбменДаннымиСлужебный.ПоместитьСообщениеДляСопоставленияДанных(УзелОбмена, ИдентификаторФайла);
	
	// У веб-клиента и тонкого клиент разные временные каталоги. 
	// Если продолжить настройку синхронизации из тонкого клиента, то будет ошибка из-за отсутствия файла во временном
	// каталоге тонкого клиента. Что бы этого не было, перемещаем файл сопоставления в каталог, к которому гарантированно
	// будет доступ у двух сеансов.
	ПереместитьФайлСообщенияДляФайловойИБ(ИдентификаторФайла);
	
	ВыйтиИзОбластиДанных(ОбластьДанных);
	
	Возврат "";
	
КонецФункции

// Соответствует операции Ping.
Функция Ping()
	// Проверка связи.
	Возврат "";
КонецФункции

// Соответствует операции TestConnection.
Функция TestConnection(ИмяПланаОбмена, КодУзла, Результат, ОбластьДанных)
	
	ВойтиВОбластьДанных(ОбластьДанных);
	
	УстановитьПривилегированныйРежим(Истина);
	
	// Проверяем наличие прав для выполнения обмена.
	Попытка
		ОбменДаннымиСервер.ПроверитьВозможностьВыполненияОбменов(Истина);
	Исключение
		Результат = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		Возврат Ложь;
	КонецПопытки;
	
	// Проверяем блокировку информационной базы для обновления.
	Попытка
		ПроверитьБлокировкуИнформационнойБазыДляОбновления();
	Исключение
		Результат = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		Возврат Ложь;
	КонецПопытки;
		
	// Проверяем наличие узла плана обмена (возможно узел уже удален).
	УзелСсылка = ОбменДаннымиСервер.УзелПланаОбменаПоКоду(ИмяПланаОбмена, КодУзла);
	Если УзелСсылка = Неопределено
		Или ОбщегоНазначения.ЗначениеРеквизитаОбъекта(УзелСсылка, "ПометкаУдаления") Тогда
		ПредставлениеПрограммы = ?(ОбщегоНазначения.РазделениеВключено(),
			Метаданные.Синоним, ОбменДаннымиПовтИсп.ИмяЭтойИнформационнойБазы());
			
		ПредставлениеПланаОбмена = Метаданные.ПланыОбмена[ИмяПланаОбмена].Представление();
			
		Результат = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'В ""%1"" не найдена настройка синхронизации данных ""%2"" с идентификатором ""%3"".'"),
			ПредставлениеПрограммы, ПредставлениеПланаОбмена, КодУзла);
			
		ВыйтиИзОбластиДанных(ОбластьДанных);
			
		Возврат Ложь;
	КонецЕсли;
	
	ВыйтиИзОбластиДанных(ОбластьДанных);
		
	Возврат Истина;
КонецФункции

// Соответствует операции ChangeNodeTransportToWSPass.
Функция ChangeNodeTransportToWSInt(ПараметрыXDTO, ОбластьДанных)
	
	ВойтиВОбластьДанных(ОбластьДанных);
	
	УстановитьПривилегированныйРежим(Истина);
	
	Параметры = СериализаторXDTO.ПрочитатьXDTO(ПараметрыXDTO);
	
	УзелОбмена = ОбменДаннымиСервер.УзелПланаОбменаПоКоду(Параметры.ИмяПланаОбмена, Параметры.КодУзлаКорреспондента);
		
	Если УзелОбмена = Неопределено Тогда
		
		ПредставлениеПрограммы = ?(ОбщегоНазначения.РазделениеВключено(),
			Метаданные.Синоним, ОбменДаннымиПовтИсп.ИмяЭтойИнформационнойБазы());
			
		ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'В ""%1"" не найден узел плана обмена ""%2"" с идентификатором ""%3"".'"),
			ПредставлениеПрограммы, Параметры.ИмяПланаОбмена, Параметры.КодУзлаКорреспондента);
			
	КонецЕсли;
		
	КонечнаяТочка = ПланыОбмена["ОбменСообщениями"].НайтиПоКоду(Параметры.КонечнаяТочкаКорреспондента);	
	
	СтруктураЗаписи = Новый Структура;
	СтруктураЗаписи.Вставить("Корреспондент", УзелОбмена);
	СтруктураЗаписи.Вставить("ВидТранспортаСообщенийОбменаПоУмолчанию", Перечисления.ВидыТранспортаСообщенийОбмена.WS);
	СтруктураЗаписи.Вставить("WSКонечнаяТочкаКорреспондента", КонечнаяТочка);
	СтруктураЗаписи.Вставить("WSОбластьДанныхКорреспондента", Параметры.ОбластьДанныхКорреспондента);
	СтруктураЗаписи.Вставить("WSИспользоватьПередачуБольшогоОбъемаДанных", Истина);
	
	ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Изменение транспорта узла ""%1"" плана обмена ""%2"" в области данных %3 на ""Интернет"".'"),
		Параметры.КодУзлаКорреспондента, Параметры.ИмяПланаОбмена, ОбластьДанных);
			
	ЗаписьЖурналаРегистрации(ОбменДаннымиВебСервис.СобытиеЖурналаРегистрацииИзменениеТранспортаНаWS(),
		УровеньЖурналаРегистрации.Информация, , , ТекстСообщения);
	
	РегистрыСведений.НастройкиТранспортаОбменаДанными.ДобавитьЗапись(СтруктураЗаписи);
	
	СтруктураЗаписи = Новый Структура("Корреспондент", УзелОбмена);
	ОбменДаннымиСлужебный.УдалитьНаборЗаписейВРегистреСведений(СтруктураЗаписи, "НастройкиТранспортаОбменаОбластиДанных");
	
	ВыйтиИзОбластиДанных(ОбластьДанных);
	
КонецФункции

// Соответствует операции Callback.
Функция Callback(TaskID, Error, Zone)
	
	ВойтиВОбластьДанных(Zone);
	
	УстановитьПривилегированныйРежим(Истина);
	
	МодульОбменДаннымиВнутренняяПубликация = ОбщегоНазначения.ОбщийМодуль("ОбменДаннымиВнутренняяПубликация");	
	МодульОбменДаннымиВнутренняяПубликация.ОтметитьВыполнениеЗадачи(TaskID, Error);
		
	Если Error = "" Тогда
		
		Задача = МодульОбменДаннымиВнутренняяПубликация.СледующаяЗадача(TaskID);
		ЗадачаПред = TaskID;
		
		Если Задача = Неопределено Тогда
			Возврат "";	
		КонецЕсли;
		
		ПараметрыПроцедуры = Новый Массив;
		ПараметрыПроцедуры.Добавить(Задача);
		ПараметрыПроцедуры.Добавить(ЗадачаПред);

		Ключ = Задача.ИдентификаторЗадачи;

		ПараметрыЗадания = Новый Структура;
		ПараметрыЗадания.Вставить("Ключ", Лев(Ключ, 120));	
		ПараметрыЗадания.Вставить("ИмяМетода"    , "ОбменДаннымиВнутренняяПубликация.ВыполнитьОчередьЗадач");
		ПараметрыЗадания.Вставить("ОбластьДанных", Zone);
		ПараметрыЗадания.Вставить("Использование", Истина);
		ПараметрыЗадания.Вставить("ЗапланированныйМоментЗапуска", ТекущаяДатаСеанса());
		ПараметрыЗадания.Вставить("Параметры", ПараметрыПроцедуры);

		МодульОчередьЗаданий = ОбщегоНазначения.ОбщийМодуль("ОчередьЗаданий");
		МодульОчередьЗаданий.ДобавитьЗадание(ПараметрыЗадания);
	
	Иначе
		
		Задача = МодульОбменДаннымиВнутренняяПубликация.ЗадачаПоИдентификатору(TaskID);
		
		Отказ = Ложь;
		СтруктураНастроекОбмена = 
			МодульОбменДаннымиВнутренняяПубликация.НастройкиОбменаДляУзлаИнформационнойБазы(Задача.УзелИнформационнойБазы, Задача.Действие, Отказ);
		СтруктураНастроекОбмена.РезультатВыполненияОбмена = Перечисления.РезультатыВыполненияОбмена.Ошибка;
		
		ОбменДаннымиСервер.ЗаписьЖурналаРегистрацииОбменаДанными(Error, СтруктураНастроекОбмена, Истина);
		ОбменДаннымиСервер.ЗафиксироватьЗавершениеОбмена(СтруктураНастроекОбмена);
		
	КонецЕсли;
	
	ВыйтиИзОбластиДанных(Zone);
	
КонецФункции

// Соответствует операции ChekTask.
Функция TaskStatus(TaskID)
	
	УстановитьПривилегированныйРежим(Истина);
	
	ПараметрыЗадания = Новый Структура("Ключ", TaskID);
	
	МодульОчередьЗаданий = ОбщегоНазначения.ОбщийМодуль("ОчередьЗаданий");
	Задания = МодульОчередьЗаданий.ПолучитьЗадания(ПараметрыЗадания);
	
	Если Задания.Количество() > 0 Тогда
		
		Состояние = Задания[0].Идентификатор.СостояниеЗадания;
		
		ОбъектМД = Состояние.Метаданные();
		МенеджерПеречисления = Перечисления[ОбъектМД.Имя];
		ИндексЗначения = МенеджерПеречисления.Индекс(Состояние);

		Возврат ОбъектМД.ЗначенияПеречисления.Получить(ИндексЗначения).Имя;
		
	Иначе
		
		Возврат "";
		
	КонецЕсли;
	
КонецФункции

// Соответствует операции StopTasks.
Функция StopTasks(TasksID, Zone)
	
	ВойтиВОбластьДанных(Zone);
	
	УстановитьПривилегированныйРежим(Истина);
	
	ИдентификаторыЗадач = СериализаторXDTO.ПрочитатьXDTO(TasksID);
	
	Для Каждого ИдентификаторЗадачи Из ИдентификаторыЗадач Цикл
		
		Отбор = Новый Структура("Ключ", ИдентификаторЗадачи);
		МодульОчередьЗаданий = ОбщегоНазначения.ОбщийМодуль("ОчередьЗаданий");
		Задания = МодульОчередьЗаданий.ПолучитьЗадания(Отбор);
		
		Если Задания.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли;	
			
		УникальныйИдентификаторФЗ = Задания[0].Идентификатор.ИсполняющееФоновоеЗадание;
			
		Если Не ЗначениеЗаполнено(УникальныйИдентификаторФЗ) Тогда
			Продолжить;
		КонецЕсли;
		
		ФоновоеЗадание = ФоновыеЗадания.НайтиПоУникальномуИдентификатору(УникальныйИдентификаторФЗ);
		Если ФоновоеЗадание <> Неопределено Тогда
			ФоновоеЗадание.Отменить();
		КонецЕсли;
		
	КонецЦикла;
	
	ВыйтиИзОбластиДанных(Zone);
	
	Возврат "";
		
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Локальные служебные процедуры и функции.

Процедура ПроверитьБлокировкуИнформационнойБазыДляОбновления()
	
	Если ЗначениеЗаполнено(ОбновлениеИнформационнойБазыСлужебный.ИнформационнаяБазаЗаблокированаДляОбновления()) Тогда
		
		ВызватьИсключение НСтр("ru = 'Синхронизация данных временно недоступна в связи с обновлением приложения в Интернете.'");
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ВыполнитьВыгрузкуДанныхВКлиентСерверномРежиме(ИмяПланаОбмена,
														КодУзлаИнформационнойБазы,
														ИдентификаторФайла,
														ДлительнаяОперация,
														ИдентификаторОперации,
														ДлительнаяОперацияРазрешена)
	
	КлючФоновогоЗадания = КлючФоновогоЗаданияВыгрузкиЗагрузкиДанных(ИмяПланаОбмена,
		КодУзлаИнформационнойБазы,
		НСтр("ru = 'Выгрузка'"));
	
	Если ЕстьАктивныеФоновыеЗаданияСинхронизацииДанных(КлючФоновогоЗадания) Тогда
		ВызватьИсключение НСтр("ru = 'Синхронизация данных уже выполняется.'");
	КонецЕсли;
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("ИмяПланаОбмена", ИмяПланаОбмена);
	ПараметрыПроцедуры.Вставить("КодУзлаИнформационнойБазы", КодУзлаИнформационнойБазы);
	ПараметрыПроцедуры.Вставить("ИдентификаторФайла", ИдентификаторФайла);
	ПараметрыПроцедуры.Вставить("ИспользоватьСжатие", Истина);
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(Новый УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НСтр("ru = 'Выгрузка данных через веб-сервис.'");
	ПараметрыВыполнения.КлючФоновогоЗадания = КлючФоновогоЗадания;
	
	ПараметрыВыполнения.ЗапуститьНеВФоне = Не ДлительнаяОперацияРазрешена;
	ПараметрыВыполнения.ЗапуститьВФоне   = ДлительнаяОперацияРазрешена;
	
	ФоновоеЗадание = ДлительныеОперации.ВыполнитьВФоне(
		"ОбменДаннымиВебСервис.ВыполнитьВыгрузкуДляУзлаИнформационнойБазыВСервисПередачиФайлов",
		ПараметрыПроцедуры,
		ПараметрыВыполнения);
		
	Если ФоновоеЗадание.Статус = "Выполняется" Тогда
		ИдентификаторОперации = Строка(ФоновоеЗадание.ИдентификаторЗадания);
		ДлительнаяОперация = Истина;
		Возврат;
	ИначеЕсли ФоновоеЗадание.Статус = "Выполнено" Тогда
		ДлительнаяОперация = Ложь;
		Возврат;
	Иначе
		Сообщение = НСтр("ru = 'Ошибка при выгрузке данных через веб-сервис.'");
		Если ЗначениеЗаполнено(ФоновоеЗадание.ПодробноеПредставлениеОшибки) Тогда
			Сообщение = ФоновоеЗадание.ПодробноеПредставлениеОшибки;
		КонецЕсли;
		
		ЗаписьЖурналаРегистрации(ОбменДаннымиСервер.СобытиеЖурналаРегистрацииВыгрузкаДанныхВСервисПередачиФайлов(),
			УровеньЖурналаРегистрации.Ошибка, , , Сообщение);
		
		ВызватьИсключение Сообщение;
	КонецЕсли;
	
КонецПроцедуры

Процедура ВыполнитьВыгрузкуДанныхВКлиентСерверномРежимеВнутренняяПубликация(ИмяПланаОбмена,
		КодУзлаИнформационнойБазы, ИдентификаторЗадачи, ОбластьДанных)
			
	ПараметрыПроцедуры = Новый Массив;
	ПараметрыПроцедуры.Добавить(ИмяПланаОбмена);
	ПараметрыПроцедуры.Добавить(КодУзлаИнформационнойБазы);
	ПараметрыПроцедуры.Добавить(ИдентификаторЗадачи);
	
	Ключ = ИдентификаторЗадачи;
	
	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("Ключ", Лев(Ключ, 120));
	ПараметрыЗадания.Вставить("ИмяМетода"    , "ОбменДаннымиВнутренняяПубликация.ВыполнитьВыгрузкуДляУзлаИнформационнойБазыВСервисПередачиФайлов");
	ПараметрыЗадания.Вставить("ОбластьДанных", ОбластьДанных);
	ПараметрыЗадания.Вставить("Использование", Истина);
	ПараметрыЗадания.Вставить("ЗапланированныйМоментЗапуска", ТекущаяДатаСеанса());
	ПараметрыЗадания.Вставить("Параметры", ПараметрыПроцедуры);
	
	МодульОчередьЗаданий = ОбщегоНазначения.ОбщийМодуль("ОчередьЗаданий");
	МодульОчередьЗаданий.ДобавитьЗадание(ПараметрыЗадания);
	
КонецПроцедуры

Процедура ВыполнитьЗагрузкуДанныхВКлиентСерверномРежиме(ИмяПланаОбмена,
													КодУзлаИнформационнойБазы,
													ИдентификаторФайла,
													ДлительнаяОперация,
													ИдентификаторОперации,
													ДлительнаяОперацияРазрешена)
	
													
	КлючФоновогоЗадания = КлючФоновогоЗаданияВыгрузкиЗагрузкиДанных(ИмяПланаОбмена,
		КодУзлаИнформационнойБазы,
		НСтр("ru = 'Загрузка'"));
	
	Если ЕстьАктивныеФоновыеЗаданияСинхронизацииДанных(КлючФоновогоЗадания) Тогда
		ВызватьИсключение НСтр("ru = 'Синхронизация данных уже выполняется.'");
	КонецЕсли;
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("ИмяПланаОбмена", ИмяПланаОбмена);
	ПараметрыПроцедуры.Вставить("КодУзлаИнформационнойБазы", КодУзлаИнформационнойБазы);
	ПараметрыПроцедуры.Вставить("ИдентификаторФайла", ИдентификаторФайла);
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(Новый УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НСтр("ru = 'Загрузка данных через веб-сервис.'");
	ПараметрыВыполнения.КлючФоновогоЗадания = КлючФоновогоЗадания;
	
	ПараметрыВыполнения.ЗапуститьНеВФоне = Не ДлительнаяОперацияРазрешена;
	ПараметрыВыполнения.ЗапуститьВФоне   = ДлительнаяОперацияРазрешена;
	
	ФоновоеЗадание = ДлительныеОперации.ВыполнитьВФоне(
		"ОбменДаннымиВебСервис.ВыполнитьЗагрузкуДляУзлаИнформационнойБазыИзСервисаПередачиФайлов",
		ПараметрыПроцедуры,
		ПараметрыВыполнения);
		
	Если ФоновоеЗадание.Статус = "Выполняется" Тогда
		ИдентификаторОперации = Строка(ФоновоеЗадание.ИдентификаторЗадания);
		ДлительнаяОперация = Истина;
		Возврат;
	ИначеЕсли ФоновоеЗадание.Статус = "Выполнено" Тогда
		ДлительнаяОперация = Ложь;
		Возврат;
	Иначе
		
		Сообщение = НСтр("ru = 'Ошибка при загрузке данных через веб-сервис.'");
		Если ЗначениеЗаполнено(ФоновоеЗадание.ПодробноеПредставлениеОшибки) Тогда
			Сообщение = ФоновоеЗадание.ПодробноеПредставлениеОшибки;
		КонецЕсли;
		
		ЗаписьЖурналаРегистрации(ОбменДаннымиСервер.СобытиеЖурналаРегистрацииЗагрузкаДанныхИзСервисаПередачиФайлов(),
			УровеньЖурналаРегистрации.Ошибка, , , Сообщение);
		
		ВызватьИсключение Сообщение;
	КонецЕсли;
	
КонецПроцедуры

Процедура ВыполнитьЗагрузкуДанныхВКлиентСерверномРежимеВнутренняяПубликация(ИмяПланаОбмена,
		КодУзлаИнформационнойБазы, ИдентификаторЗадачи, ИдентификаторФайла, ОбластьДанных)
		
	ПараметрыПроцедуры = Новый Массив;
	ПараметрыПроцедуры.Добавить(ИмяПланаОбмена);
	ПараметрыПроцедуры.Добавить(КодУзлаИнформационнойБазы);
	ПараметрыПроцедуры.Добавить(ИдентификаторЗадачи);
	ПараметрыПроцедуры.Добавить(ИдентификаторФайла);
	
	Ключ = ИдентификаторЗадачи;
	
	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("Ключ", Лев(Ключ, 120));
	ПараметрыЗадания.Вставить("ИмяМетода"    , "ОбменДаннымиВнутренняяПубликация.ВыполнитьЗагрузкуДляУзлаИнформационнойБазыИзСервисаПередачиФайлов");
	ПараметрыЗадания.Вставить("ОбластьДанных", ОбластьДанных);
	ПараметрыЗадания.Вставить("Использование", Истина);
	ПараметрыЗадания.Вставить("ЗапланированныйМоментЗапуска", ТекущаяДатаСеанса());
	ПараметрыЗадания.Вставить("Параметры", ПараметрыПроцедуры);
	
	МодульОчередьЗаданий = ОбщегоНазначения.ОбщийМодуль("ОчередьЗаданий");
	МодульОчередьЗаданий.ДобавитьЗадание(ПараметрыЗадания);
	
КонецПроцедуры

Функция КлючФоновогоЗаданияВыгрузкиЗагрузкиДанных(ПланОбмена, КодУзла, Действие)
	
	Возврат СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'ПланОбмена:%1 КодУзла:%2 Действие:%3'"),
		ПланОбмена,
		КодУзла,
		Действие);
	
КонецФункции

Функция ЕстьАктивныеФоновыеЗаданияСинхронизацииДанных(КлючФоновогоЗадания)
	
	Отбор = Новый Структура;
	Отбор.Вставить("Ключ", КлючФоновогоЗадания);
	Отбор.Вставить("Состояние", СостояниеФоновогоЗадания.Активно);
	
	АктивныеФоновыеЗадания = ФоновыеЗадания.ПолучитьФоновыеЗадания(Отбор);
	
	Возврат (АктивныеФоновыеЗадания.Количество() > 0);
	
КонецФункции

Функция ПолучитьИмяФайлаЧасти(PartNumber)
	
	Результат = "data.zip.[n]";
	
	Возврат СтрЗаменить(Результат, "[n]", Формат(PartNumber, "ЧГ=0"));
КонецФункции

Функция ВременныйКаталогВыгрузки(Знач ИдентификаторСессии)
	
	УстановитьПривилегированныйРежим(Истина);
	
	ВременныйКаталог = "{ИдентификаторСессии}";
	ВременныйКаталог = СтрЗаменить(ВременныйКаталог, "ИдентификаторСессии", Строка(ИдентификаторСессии));
	
	Результат = ОбщегоНазначенияКлиентСервер.ПолучитьПолноеИмяФайла(ОбменДаннымиСервер.КаталогВременногоХранилищаФайлов(), ВременныйКаталог);
	
	Возврат Результат;
КонецФункции

Функция НайтиФайлЧасти(Знач Каталог, Знач НомерФайла)
	
	Для КоличествоРазрядов = КоличествоРазрядовЧисла(НомерФайла) По 5 Цикл
		
		ФорматнаяСтрока = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("ЧЦ=%1; ЧВН=; ЧГ=0", Строка(КоличествоРазрядов));
		
		ИмяФайла = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("data.zip.%1", Формат(НомерФайла, ФорматнаяСтрока));
		
		ИменаФайлов = НайтиФайлы(Каталог, ИмяФайла);
		
		Если ИменаФайлов.Количество() > 0 Тогда
			
			Возврат ИменаФайлов;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Новый Массив;
КонецФункции

Функция КоличествоРазрядовЧисла(Знач Число)
	
	Возврат СтрДлина(Формат(Число, "ЧДЦ=0; ЧГ=0"));
	
КонецФункции

Процедура ПереместитьФайлСообщенияДляФайловойИБ(ИдентификаторФайла)
	
	Если НЕ ОбщегоНазначения.ИнформационнаяБазаФайловая() Тогда
		Возврат;
	КонецЕсли;
		
	ТекстЗапроса =
		"ВЫБРАТЬ
		|	СообщенияОбменаДанными.ИмяФайлаСообщения КАК ИмяФайла
		|ИЗ
		|	РегистрСведений.СообщенияОбменаДанными КАК СообщенияОбменаДанными
		|ГДЕ
		|	СообщенияОбменаДанными.ИдентификаторСообщения = &ИдентификаторСообщения";

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ИдентификаторСообщения", Строка(ИдентификаторФайла));
	Запрос.Текст = ТекстЗапроса;
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	ИмяФайла = Выборка.ИмяФайла;
	ИмяФайлаСообщения = ОбщегоНазначенияКлиентСервер.ПолучитьПолноеИмяФайла(ОбменДаннымиСервер.КаталогВременногоХранилищаФайлов(), ИмяФайла);
	
	ИмяКаталога = ОбменДаннымиСервер.ИмяКаталогаДляСопоставленияФайловаяИБ();
	
	Каталог = Новый Файл(ИмяКаталога);
	Если Не Каталог.Существует() Тогда
		СоздатьКаталог(ИмяКаталога);	
	КонецЕсли;

	ИмяНовогоФайлаСообщения = ОбменДаннымиСервер.ПолноеИмяФайлаДляСопоставленияФайловаяИБ(ИмяФайла);
	
	ПереместитьФайл(ИмяФайлаСообщения, ИмяНовогоФайлаСообщения);	
	
КонецПроцедуры

Процедура ВойтиВОбластьДанных(ОбластьДанных)
	
	Если ОбластьДанных = 0 
		Или Не ОбщегоНазначения.РазделениеВключено() Тогда
		Возврат;
	КонецЕсли;
		
	МодульРаботаВМоделиСервиса = ОбщегоНазначения.ОбщийМодуль("РаботаВМоделиСервиса");

	МодульТехнологияСервиса = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервиса");
	ВерсияБТС = МодульТехнологияСервиса.ВерсияБиблиотеки();

	Если ОбщегоНазначенияКлиентСервер.СравнитьВерсии(ВерсияБТС, "2.0.7.46") >= 0 Тогда
		МодульРаботаВМоделиСервиса.ВойтиВОбластьДанных(ОбластьДанных); //АПК: 287
	Иначе
		МодульРаботаВМоделиСервиса.УстановитьРазделениеСеанса(Истина, ОбластьДанных);
	КонецЕсли;
	
КонецПроцедуры

Процедура ВыйтиИзОбластиДанных(ОбластьДанных)
	
	Если ОбластьДанных = 0 
		Или Не ОбщегоНазначения.РазделениеВключено() Тогда
		Возврат;
	КонецЕсли;
		
	МодульРаботаВМоделиСервиса = ОбщегоНазначения.ОбщийМодуль("РаботаВМоделиСервиса");

	МодульТехнологияСервиса = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервиса");
	ВерсияБТС = МодульТехнологияСервиса.ВерсияБиблиотеки();

	Если ОбщегоНазначенияКлиентСервер.СравнитьВерсии(ВерсияБТС, "2.0.7.46") >= 0 Тогда
		МодульРаботаВМоделиСервиса.ВыйтиИзОбластиДанных(); //АПК: 287
	Иначе
		МодульРаботаВМоделиСервиса.УстановитьРазделениеСеанса(Ложь);
	КонецЕсли;
	
КонецПроцедуры


#КонецОбласти
