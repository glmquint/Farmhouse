/*Test script per l'operazione 1*/
INSERT INTO Locale(codiceLocale,temperatura,umidità,orientazioneFinestre,tollerabilitaAzoto,tollerabilitaSporcizia,tollerabilitaMetano,codiceStalla,nomeAgriturismo,specieOspitata,altezza,lunghezza,larghezza) 
	VALUES (66,28,39,'S',8,5,5,1,'Settesoldi','bos lobe',486,2299,1096);
INSERT INTO Locale(codiceLocale,temperatura,umidità,orientazioneFinestre,tollerabilitaAzoto,tollerabilitaSporcizia,tollerabilitaMetano,codiceStalla,nomeAgriturismo,specieOspitata,altezza,lunghezza,larghezza) 
	VALUES (67,28,39,'S',8,5,5,1,'Settesoldi','bos lobe',486,2299,1096);
INSERT INTO Locale(codiceLocale,temperatura,umidità,orientazioneFinestre,tollerabilitaAzoto,tollerabilitaSporcizia,tollerabilitaMetano,codiceStalla,nomeAgriturismo,specieOspitata,altezza,lunghezza,larghezza) 
	VALUES (68,28,39,'S',8,5,5,1,'Settesoldi','bos lobe',486,2299,1096);
INSERT INTO Animale(codice,sesso,specie,famiglia,idMadre,idPadre,dataDiNascita,altezza,peso,razza,latitudine,longitudine,orario,codiceGps,codLocale) 
	VALUES (5,'M','bos lobe','tetracerus',NULL,NULL,'1966-05-19',92,191,'tedesca',117.249,-178.78,'2012-03-11 18:33:37',4,66);
INSERT INTO Animale(codice,sesso,specie,famiglia,idMadre,idPadre,dataDiNascita,altezza,peso,razza,latitudine,longitudine,orario,codiceGps,codLocale) 
	VALUES (6,'F','bos lobe','tetracerus',NULL,NULL,'1967-05-19',92,191,'tedesca',117.249,-178.78,'2012-03-11 18:33:37',5,67);
INSERT INTO Animale(codice,sesso,specie,famiglia,idMadre,idPadre,dataDiNascita,altezza,peso,razza,latitudine,longitudine,orario,codiceGps,codLocale) 
	VALUES (7,'M','bos lobe','tetracerus',NULL,NULL,'1968-05-19',92,191,'tedesca',117.249,-178.78,'2012-03-11 18:33:37',6,68);
INSERT INTO Animale(codice,sesso,specie,famiglia,idMadre,idPadre,dataDiNascita,altezza,peso,razza,latitudine,longitudine,orario,codiceGps,codLocale) 
	VALUES (8,'M','bos lobe','tetracerus',NULL,NULL,'1966-05-19',92,191,'tedesca',117.249,-178.78,'2012-03-11 18:33:37',0,67);
INSERT INTO Animale(codice,sesso,specie,famiglia,idMadre,idPadre,dataDiNascita,altezza,peso,razza,latitudine,longitudine,orario,codiceGps,codLocale) 
	VALUES (9,'F','bos lobe','tetracerus',NULL,NULL,'1967-05-19',92,191,'tedesca',117.249,-178.78,'2012-03-11 18:33:37',7,68);
INSERT INTO Animale(codice,sesso,specie,famiglia,idMadre,idPadre,dataDiNascita,altezza,peso,razza,latitudine,longitudine,orario,codiceGps,codLocale) 
	VALUES (10,'M','bos lobe','tetracerus',NULL,NULL,'1968-05-19',92,191,'tedesca',117.249,-178.78,'2012-03-11 18:33:37',8,66);
INSERT INTO Animale(codice,sesso,specie,famiglia,idMadre,idPadre,dataDiNascita,altezza,peso,razza,latitudine,longitudine,orario,codiceGps,codLocale) 
	VALUES (11,'M','bos lobe','tetracerus',NULL,NULL,'1966-05-19',92,191,'tedesca',117.249,-178.78,'2012-03-11 18:33:37',9,68);
INSERT INTO Animale(codice,sesso,specie,famiglia,idMadre,idPadre,dataDiNascita,altezza,peso,razza,latitudine,longitudine,orario,codiceGps,codLocale) 
	VALUES (12,'F','bos lobe','tetracerus',NULL,NULL,'1967-05-19',92,191,'tedesca',117.249,-178.78,'2012-03-11 18:33:37',10,66);
INSERT INTO Animale(codice,sesso,specie,famiglia,idMadre,idPadre,dataDiNascita,altezza,peso,razza,latitudine,longitudine,orario,codiceGps,codLocale) 
	VALUES (13,'M','bos lobe','tetracerus',NULL,NULL,'1968-05-19',92,191,'tedesca',117.249,-178.78,'2012-03-11 18:33:37',11,67);
INSERT INTO Foraggio(fibre,proteine,glucidi,cereali,frutta,piante,forma,kcalkg) 
	VALUES (100,960,870,39,3,10,'insilato',5500);
INSERT INTO Foraggio(fibre,proteine,glucidi,cereali,frutta,piante,forma,kcalkg) 
	VALUES (101,961,871,39,3,10,'insilato',5500);
INSERT INTO Foraggio(fibre,proteine,glucidi,cereali,frutta,piante,forma,kcalkg) 
	VALUES (102,962,872,39,3,10,'insilato',5500);
INSERT INTO Acqua(concentrazioneSali,concentrazioneVitamine) 
	VALUES (10,0);
INSERT INTO Acqua(concentrazioneSali,concentrazioneVitamine) 
	VALUES (11,1);
INSERT INTO Acqua(concentrazioneSali,concentrazioneVitamine) 
	VALUES (12,2);
INSERT INTO Pasto(fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES (100,960,870,10,0);
INSERT INTO Pasto(fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES (101,961,871,11,1);
INSERT INTO Pasto(fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES (102,962,872,12,2);
INSERT INTO PastoPerLocale(giorno_orario,codLocale,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES ('2019-01-04 01:39:20',66,100,960,870,10,0);
INSERT INTO PastoPerLocale(giorno_orario,codLocale,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES ('2019-01-04 01:39:20',67,100,960,870,10,0);
INSERT INTO PastoPerLocale(giorno_orario,codLocale,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES ('2019-01-05 01:39:20',66,100,960,870,10,0);
INSERT INTO PastoPerLocale(giorno_orario,codLocale,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES ('2019-01-05 01:39:20',67,100,960,870,10,0);
INSERT INTO PastoPerLocale(giorno_orario,codLocale,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES ('2019-01-06 01:39:20',66,100,960,870,10,0);
INSERT INTO PastoPerLocale(giorno_orario,codLocale,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES ('2019-02-06 01:39:20',67,100,960,870,10,0);
INSERT INTO PastoPerLocale(giorno_orario,codLocale,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES ('2019-02-07 01:39:20',67,100,960,870,10,0);
INSERT INTO PastoPerLocale(giorno_orario,codLocale,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES ('2019-02-06 01:39:20',66,101,961,871,11,1);
INSERT INTO PastoPerLocale(giorno_orario,codLocale,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES ('2019-02-07 01:39:20',66,101,961,871,11,1);
INSERT INTO IndiciSalute(codAnimale,dataRilevazione,tipologiaRespirazione,lucentezzaPelo,vigilanza,idratazione,deambulazione,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES (5,'2019-01-01',12,34,95,48,82,100,960,870,10,0);
INSERT INTO IndiciSalute(codAnimale,dataRilevazione,tipologiaRespirazione,lucentezzaPelo,vigilanza,idratazione,deambulazione,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES (5,'2019-01-11',22,44,95,58,92,100,960,870,10,0);
INSERT INTO IndiciSalute(codAnimale,dataRilevazione,tipologiaRespirazione,lucentezzaPelo,vigilanza,idratazione,deambulazione,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES (6,'2019-01-14',20,40,90,60,90,100,960,870,10,0);
INSERT INTO IndiciSalute(codAnimale,dataRilevazione,tipologiaRespirazione,lucentezzaPelo,vigilanza,idratazione,deambulazione,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES (8,'2019-01-15',20,40,90,60,90,100,960,870,10,0);
INSERT INTO IndiciSalute(codAnimale,dataRilevazione,tipologiaRespirazione,lucentezzaPelo,vigilanza,idratazione,deambulazione,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES (10,'2019-01-13',24,46,97,60,94,100,960,870,10,0);
INSERT INTO IndiciSalute(codAnimale,dataRilevazione,tipologiaRespirazione,lucentezzaPelo,vigilanza,idratazione,deambulazione,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES (12,'2019-01-12',24,46,97,60,94,100,960,870,10,0);
INSERT INTO IndiciSalute(codAnimale,dataRilevazione,tipologiaRespirazione,lucentezzaPelo,vigilanza,idratazione,deambulazione,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES (12,'2019-02-17',25,45,95,65,95,101,961,871,11,1);
INSERT INTO IndiciSalute(codAnimale,dataRilevazione,tipologiaRespirazione,lucentezzaPelo,vigilanza,idratazione,deambulazione,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES (13,'2019-01-16',25,45,95,65,95,100,960,870,10,0);
INSERT INTO IndiciSalute(codAnimale,dataRilevazione,tipologiaRespirazione,lucentezzaPelo,vigilanza,idratazione,deambulazione,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES (13,'2019-02-16',25,45,95,65,95,101,961,871,11,1);
INSERT INTO PastoPerLocale(giorno_orario,codLocale,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES ('2019-02-08 01:39:20',66,101,961,871,11,1);
INSERT INTO PastoPerLocale(giorno_orario,codLocale,fibre,proteine,glucidi,concentrazioneSali,concentrazioneVitamine) 
	VALUES ('2019-02-08 01:39:20',67,101,961,871,11,1);
    
CALL OP1_controllo_qualita_pasto(100, 960, 870, 10, 0);/*fibre, proteine, glucidi, sali, vitamine*/
CALL OP1_controllo_qualita_pasto(101, 961, 871, 11, 1);/*fibre, proteine, glucidi, sali, vitamine*/
