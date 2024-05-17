use SINCRO_PCPNISIRA

-----------------------------------------------------------
CREATE TABLE FormDataNotifier (
	idDataNotifier int IDENTITY(1,1) PRIMARY KEY,
	nameNotifier varchar(150) not null,

    adressNotifier varchar(200) not null,
	telef1 varchar(25) not null,
	telef2 varchar(25) not null,
	EORI varchar(100) null,
	Fax varchar(55) not null,
	contactPerson varchar(100) not null,
	taxID varchar(120) null,
	email varchar(40) not null,
	website varchar(70) null,
	estado tinyint,
    idDataConsignee int null
	FOREIGN KEY (idDataConsignee) REFERENCES FormDataConsignee(idDataConsignee),
	secCreate datetime null,
	secUpdate datetime null
)

CREATE TABLE FormDataConsignee (
	idDataConsignee int IDENTITY(1,1) PRIMARY KEY,
	nameConsignee varchar(150) not null,
    addressConsignee varchar(200) not null,
	telef1 varchar(25) not null,
	telef2 varchar(25) not null,
	EORI varchar(100) null,
	Fax varchar(55) not null,
	contactPerson varchar(100) not null,
	taxID varchar(120)  null,
	email varchar(40) not null,
	website varchar(70) null,

	estado tinyint,
	secCreate datetime null,
	secUpdate datetime null,
)

----------------------------------------------------

create table FormRequiredDocuments(
	idDocReq int IDENTITY(1,1) PRIMARY KEY,
	packingList tinyint null,
	plasticStatement tinyint null,
	INVIMA tinyint null,
	FDA tinyint null,
	PPQ tinyint null,
	ColdTreatment tinyint null,
	InspectionFormat tinyint null,
	MicrobioAnalysis tinyint null,
	InsuranceCertificate tinyint null,
	DAM tinyint null,
	QualityReport tinyint null,
	Other varchar(200) null,
	estado tinyint null,
	secCreate datetime null,
	secUpdate datetime null,
)

------------------------------------------------
create table FormAddressEmail
(
	idAddressEmail int IDENTITY(1,1) PRIMARY KEY,
	email varchar(50) not null,
    id
	estado tinyint null,
	secCreate datetime null,
	secUpdate datetime null,
)

create table FormAddressOriginalsDoc
(
	idAddressOriginalsDoc int IDENTITY(1,1) PRIMARY KEY,
	nameCompany varchar(150)  null,
	addressCompany varchar(150)  null,
	telef varchar(25)  null,
	contactPerson varchar(100)  null,
	taxID varchar(120)  null,
	emailAddress varchar(70)  null,
	country varchar(70)  null,
	city varchar(120)  null,
	state_city varchar(120)  null,
	postalCode varchar(50)  null,
	estado tinyint null,
	secCreate datetime null,
	secUpdate datetime null,
)

--------------------------------------------------------
create table FormSendPhysicalDocuments
(
	idSendPhysicalDocument int IDENTITY(1,1) PRIMARY KEY,
	bill tinyint null,
	originalCertificate tinyint null,
	packingList tinyint null,
	phytosanitaryCertificate tinyint null,
	Other varchar(200) null,
	estado tinyint null,
	secCreate datetime null,
	secUpdate datetime null,
)


--------------------------------------------------------------------------
-- MAIN TABLE !!!

create table Form (
	idForm int IDENTITY(1,1) PRIMARY KEY,
    idClient int not null,
	nameClient varchar(200) not null,

	--country - port
	CountryName int not null
	FOREIGN KEY (CountryName) REFERENCES FormCountry(idCountry),
	DestinationPort int not null
	FOREIGN KEY (DestinationPort) REFERENCES FormPort(idPort),
	DestinationFinal int not null
	FOREIGN KEY (DestinationFinal) REFERENCES FormPortDestination(idPort),

	--datos factura
	BillName varchar(120) not null,
	BillAddress varchar(200) not null,
	BillInfoAdd varchar(500) null,

	--conocimiento embarque
	FreightPayer varchar(200) not null,
	PlacePayment varchar(200) not null,
	emissionType varchar(100) not null,
	FreightPayerInfoAdd varchar(500) null,

	idDataConsignee int not null,
	FOREIGN KEY (idDataConsignee) REFERENCES FormDataConsignee(idDataConsignee),
	BLDataInfoAdd varchar(500) null,

	--conocimiento fitosanitario
	IsAllowedPhyto tinyint not null,
	PhytoName varchar(200) not null,
	PhytoAddress varchar(200) not null,
	PhytoCountryPort varchar(200) not null,
	PhytoInfoAdd varchar(500) null,
	PhytoTransitCountry varchar(100) not null,
	PhytoExportSENASA varchar(500) null,

	--certificado origen
	CertificateNameOrigin varchar(200) not null,
	CertificateAddressOrigin varchar(200) not null,
	CertificateInfoAdd varchar(500) null,

	--certificado calidad y otros doc adicionales requeridos
	idDocReq int
	FOREIGN KEY (idDocReq) REFERENCES FormRequiredDocuments(idDocReq),

	--direccion de envio de documentos
	isConsigneeSendDoc tinyint null,
    isNotifier1SendDoc tinyint null,
    isNotifier2SendDoc tinyint null,

	idAddressOriginalsDoc int null
	FOREIGN KEY (idAddressOriginalsDoc) REFERENCES FormAddressOriginalsDoc(idAddressOriginalsDoc),


	IsSendScanning tinyint null,
	idSendPhysicalDocument int null
	FOREIGN KEY (idSendPhysicalDocument) REFERENCES FormSendPhysicalDocuments(idSendPhysicalDocument),


	estado tinyint null,
	secCreate datetime null,
	secUpdate datetime null,
)
