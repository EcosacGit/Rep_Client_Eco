USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_GetDataFormXUpdate]    Script Date: 20/08/2024 13:45:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- select * from Form
-- select * from FormRequiredDocuments
-- select * from FormDataConsignee
-- select * from FormDataNotifier
-- Form_GetDataFormXUpdate 1

ALTER PROCEDURE [dbo].[Form_GetDataFormXUpdate]
    @idForm    int
AS
BEGIN
    SET XACT_ABORT ON
    SET NOCOUNT ON;

    BEGIN TRY

		SELECT
        fm.idForm as idForm,
        fm.idClient as idCliente,
        fm.nameClient as nombreCliente,
        fm.CountryName as idCountry,
        (SELECT TOP 1
            descCountry
        From FormCountry
        where idCountry = CountryName) as nombrePais,
        fm.DestinationPort as idPuertoDestino,
        (SELECT TOP 1
            descPort
        From FormPort
        where idPort = DestinationPort) as nombrePuertoDestino,
        fm.DestinationFinal as idPuertoFinal,
        (SELECT TOP 1
            descPort
        From FormPort
        where idPort = DestinationFinal) as nombrePuertoFinal,
        fm.BillName  as NombreFactura,
        fm.BillAddress as DireccionFactura,
        fm.BillInfoAdd as InfoAdicionalFactura,
        fm.FreightPayer as PagadorFlete,
        fm.PlacePayment as LugarPago,
        fm.emissionType as TipoEmisionBL, --hacer que el string coincida con el texto(formatear en js
        ISNULL(fm.FreightPayerInfoAdd , '-') as InfoAdicionalPagoFlete,

        -- Consignataraiooo

        fm.idDataConsignee as IdConsignatario, -- de aqui sale toda la logica del consignatario y su notificante
        (SELECT TOP 1
            nameConsignee
        From FormDataConsignee
        where idDataConsignee = fm.idDataConsignee) as NombreConsignatario,

        (SELECT TOP 1
            addressConsignee
        From FormDataConsignee
        where idDataConsignee = fm.idDataConsignee) as direccionConsignatario,

        (SELECT TOP 1
            telef1
        From FormDataConsignee
        where idDataConsignee = fm.idDataConsignee) as telefono1Consignatario,

        (SELECT TOP 1
            telef2
        From FormDataConsignee
        where idDataConsignee = fm.idDataConsignee) as telefono2Consignatario,

        (SELECT TOP 1
            EORI
        From FormDataConsignee
        where idDataConsignee = fm.idDataConsignee) as EoriConsignatario,

        (SELECT TOP 1
            Fax
        From FormDataConsignee
        where idDataConsignee = fm.idDataConsignee) as FaxConsignatario,

        (SELECT TOP 1
            contactPerson
        From FormDataConsignee
        where idDataConsignee = fm.idDataConsignee) as PersonaContactoConsignatario,

        (SELECT TOP 1
            taxID
        From FormDataConsignee
        where idDataConsignee = fm.idDataConsignee) as IdentificacionFiscalConsignatario,

        (SELECT TOP 1
            email
        From FormDataConsignee
        where idDataConsignee = fm.idDataConsignee) as EmailConsignatario,

        (SELECT TOP 1
            website
        From FormDataConsignee
        where idDataConsignee = fm.idDataConsignee) as websiteConsignatario,


        -- NOTIFIER
        fdn.nameNotifier  as NombreNotificante,
        fdn.adressNotifier  as DireccionNotificante,
        fdn.telef1 as telefono1Notificante,
        fdn.telef2 as telefono2Notificante,
        fdn.EORI  as EoriNotificante,
        fdn.Fax as FaxNotificante,
        fdn.contactPerson as PersonaContactoNotificante,
        fdn.taxID as IdentificacionFiscalNotificante,
        fdn.email as EmailNotificante,
        fdn.website as websiteNotificante,


        ISNULL(fm.BLDataInfoAdd, '-')  as InfoAdicionalBL,
        fm.IsAllowedPhyto as RequierePermisoImportacion, --En este caso es un select  1 es True  || 0 es false,
        fm.PhytoName as NombreFitosanitario,
        fm.PhytoAddress as DireccionFitosanitario,
        fm.PhytoCountryPort as PuertoDestinoPaisFitosanitario,
        fm.PhytoInfoAdd as InfoAdicionalFitosanitario, -- en caso no se agrega el mensaje es No se agrego ....
        fm.PhytoTransitCountry as TransitoInternacional,
        fm.CertificateNameOrigin as NombreCertificadoOrigen,
        fm.CertificateAddressOrigin as DireccionCertificadoOrigen,
        fm.CertificateInfoAdd as InfoAdicionalCertificado, -- en caso no se agrega el mensaje es No se agrego ....

        fm.idDocReq  as  idDocumentosRequeridos,

        -- Si es 1  es porque esta marcado  || si es 0 es porque es false (o sea no seleccionado)
        (SELECT TOP 1
            packingList
        From FormRequiredDocuments
        where idDocReq = fm.idDocReq) as packingList,

        (SELECT TOP 1
            plasticStatement
        From FormRequiredDocuments
        where idDocReq = fm.idDocReq) as plasticStatement,

        (SELECT TOP 1
            INVIMA
        From FormRequiredDocuments
        where idDocReq = fm.idDocReq) as INVIMA,

        (SELECT TOP 1
            FDA
        From FormRequiredDocuments
        where idDocReq = fm.idDocReq) as FDA,

        (SELECT TOP 1
            PPQ
        From FormRequiredDocuments
        where idDocReq = fm.idDocReq) as PPQ,

        (SELECT TOP 1
            ColdTreatment
        From FormRequiredDocuments
        where idDocReq = fm.idDocReq) as ColdTreatment,

        (SELECT TOP 1
            InspectionFormat
        From FormRequiredDocuments
        where idDocReq = fm.idDocReq) as InspectionFormat,

        (SELECT TOP 1
            MicrobioAnalysis
        From FormRequiredDocuments
        where idDocReq = fm.idDocReq) as MicrobioAnalysis,

        (SELECT TOP 1
            InsuranceCertificate
        From FormRequiredDocuments
        where idDocReq = fm.idDocReq) as InsuranceCertificate,

        (SELECT TOP 1
            DAM
        From FormRequiredDocuments
        where idDocReq = fm.idDocReq) as DAM,

        (SELECT TOP 1
            QualityReport
        From FormRequiredDocuments
        where idDocReq = fm.idDocReq) as QualityReport,

        (SELECT TOP 1
            Other
        From FormRequiredDocuments
        where idDocReq = fm.idDocReq) as OtherDocumentosRequerimientos, -- cuando es "-"  es false en el select

        fm.isConsigneeSendDoc as MismaConsignatario, -- si es null es false el select
        fm.isNotifierSendDoc as MismaNotifier, -- si es null es false el select
        fm.idAddressOriginalsDoc as idAddressOiriginalDoc,

        (SELECT TOP 1
            nameCompany
        From FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as nombreEmpresa,

        (SELECT TOP 1
            addressCompany
        From FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as direccionEmpresa,

        (SELECT TOP 1
            telef
        From FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as telefonoEmpresa,

        (SELECT TOP 1
            contactPerson
        From FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as personaContactoEmpresa,

        (SELECT TOP 1
            taxID
        From FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as taxIDEmpresa,

        (SELECT TOP 1
            emailAddress
        From FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as correoElectricoEmpresa,

        (SELECT TOP 1
            country
        From FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as paisEmpresa,

        (SELECT TOP 1
            city
        From FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as ciudadEmpresa,

        (SELECT TOP 1
            state_city
        From FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as estadoCiudadEmpresa,

        (SELECT TOP 1
            postalCode
        From FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as codigoPostalEmpresa ,

        fm.IsSendScanning as SoloRequerieDocScaneados,
        fm.idSendPhysicalDocument as idSendPhysicalDocument,

        (SELECT TOP 1
            bill
        From FormSendPhysicalDocuments
        where idSendPhysicalDocument = fm.idSendPhysicalDocument) as billDocumentos,

        (SELECT TOP 1
            originalCertificate
        From FormSendPhysicalDocuments
        where idSendPhysicalDocument = fm.idSendPhysicalDocument) as certificadoOriginalDocumentos,

        (SELECT TOP 1
            packingList
        From FormSendPhysicalDocuments
        where idSendPhysicalDocument = fm.idSendPhysicalDocument) as packingListCertificadoDocumentos,

        (SELECT TOP 1
            phytosanitaryCertificate
        From FormSendPhysicalDocuments
        where idSendPhysicalDocument = fm.idSendPhysicalDocument) as certFitoDocumentos,

        (SELECT TOP 1
            Other
        From FormSendPhysicalDocuments
        where idSendPhysicalDocument = fm.idSendPhysicalDocument) as otrosCertificadosDocumentos,

        fm.EmailInfoAdd as EmailInfoAdd,
        fm.OriginalDocInfoAdd as OriginalDocInfoAdd,

        fm.isConsigneeSendDoc as EsConsignatario,
        fm.isNotifierSendDoc as EsNotificante,

        (select top 1
            nameCompany
        from FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as NombreEmpresaDocumentoOriginal,

        (select top 1
            addressCompany
        from FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as DireccionDocumentoOriginal,

        (select top 1
            telef
        from FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as TelefonoDocumentoOriginal,

        (select top 1
            contactPerson
        from FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as PersonaContactoDocumentoOriginal,

        (select top 1
            taxID
        from FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as TaxDocumentoOriginal,
        (select top 1
            emailAddress
        from FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as CorreoElectronicoDocumentoOriginal,
        (select top 1
            country
        from FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as PaisDocumentoOriginal,
        (select top 1
            city
        from FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as CiudadDocumentoOriginal,
        (select top 1
            state_city
        from FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as EstadoDocumentoOriginal,
        (select top 1
            postalCode
        from FormAddressOriginalsDoc
        where idAddressOriginalsDoc = fm.idAddressOriginalsDoc) as CodigoPostalDocumentoOriginal


    FROM Form fm
        left join FormDataConsignee fdc on  fdc.idDataConsignee = fm.idDataConsignee
        left join FormDataNotifier fdn on  fdc.idDataConsignee = fdn.idDataConsignee
    WHERE fm.estado = 1
        and idForm = @idForm
    order by fm.secCreate desc
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END

-- Form_GetDataFormXUpdate 1


