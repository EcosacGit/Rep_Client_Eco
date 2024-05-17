import swal from "sweetalert2";
import router from "../router";
import moment from "moment";
import _fun from "@/plugins/fun";
import _constapp from "@/plugins/const";

export default {

    /* **************************************************************************
     * Contiene las funciones javascript comunes para el proyecto,
     * todos las funciones empiezan con el prefijo "g"
     ****************************************************************************/
    alertSap(msg, type, subtitle) {

        swal.fire({
            title: msg,
            icon: type,
            subtitle: subtitle,
            timerProgressBar: true,


            timerProgressBar: true,
            showConfirmButton: false,
            allowOutsideClick: false,

            // didOpen: () => {
            //     Swal.showLoading();
            // },
            onBeforeOpen: () => {
                swal.showLoading(
                );


            }

        });
    },
    alertNisira(msg, type, subtitle) {

        swal.fire({
            title: msg,
            icon: type,
            subtitle: subtitle,
            timerProgressBar: true,


            timerProgressBar: true,
            showConfirmButton: false,
            allowOutsideClick: false,
            text: 'Sincronizando  a Nisira ... Espere un momento',
            // didOpen: () => {
            //     Swal.showLoading();
            // },
            onBeforeOpen: () => {
                swal.showLoading(
                );


            }

        });


    },
    alertSwal(title, icon) {
        swal.fire({
            icon: icon,
            title: title,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            toast: true,
            customClass: {
                title: 'font-title'
            }
        })
    },

    alertFull(msg, type, subtitle) {
        swal.fire({
            title: msg,
            icon: type,
            allowOutsideClick: false,
        });
    },

    alert(msg, type, toa = false, position = 'center') {
        type = type || "info";
        var timer = 2000;
        var ok = false;
        var cancel = false;
        switch (type) {
            case "error":
                var timer = null;
                ok = true;
                break;
            case "warning":
                var timer = 3000;
                break;
            case "info":
                var timer = 3000;
                break;
            case "question":
                var timer = null;
                ok = true;
                cancel = true;
                break;
        }
        var toast = null;

        toast = swal.mixin({
            toast: toa,
            position: position,
            showConfirmButton: ok,
            showCancelButton: cancel,
            timer: timer,

        })

        return toast.fire({
            icon: type,
            title: msg,
        });
    },

    getUserID() {
        return parseInt(localStorage.UsrID);
    },
    getCompanyCode() {
        return localStorage.CompanyID;
    },
    getCompanyCtvCode() {
        return localStorage.CtvCode;
    },

    getCompanyName() {
        return localStorage.CompanyName;
    },
    getSecurity() {
        return router.history.current.params.security;
    },

    isAdmin() {
        return router.history.current.params.security.IsLevelAdmin;
    },

    formatDateView(value) {
        let val = value;
        if (!_fun.isEmptyVal(value)) {
            val = moment(value, _constapp.FormatDateDB).format(_constapp.FormatDateView);
        }
        return val;
    },
    formatTimeView(value) {
        let val = value;
        if (!_fun.isEmptyVal(value)) {
            val = moment(value, _constapp.FormatTimeDB).format(_constapp.FormatTimeView);
        }
        return val;
    },
    formatDateTimeView(value) {
        let val = value;
        if (!_fun.isEmptyVal(value)) {
            val = moment(value, _constapp.FormatDateTimeDB).format(_constapp.FormatDateTimeView);
        }
        return val;
    },

    isEmptyVal: (val) => {
        var is = val === undefined || val === null || val === "";
        if (!is) is = val.length == 0;
        return is;
    },

    gTrim(cadena) {
        return cadena.replace(/^\s+|\s+$/g, "");
    },

    gRound(numero, decimales) {
        decimales = (!decimales ? 2 : decimales);
        var n = Math.round(numero * Math.pow(10, decimales)) / Math.pow(10, decimales);
        var nn = n.toFixed(decimales);
        return nn;
    },

    gValidarEmail(email) {
        var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        if (!filter.test(email)) {
            swal('',
                'La dirección de email es incorrecta.',
                'warning'
            );
            return false;
        }
        return true;
    },
    getRandomColor() {
        var letters = '0123456789ABCDEF'.split('');
        var color = '#';
        for (var i = 0; i < 6; i++) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    },
    downloadFile(file, type, filename) {
        const url = window.URL.createObjectURL(new Blob([file]));
        const link = document.createElement("a");
        link.href = url;

        link.setAttribute("download", filename + "_" + Math.floor(Math.random() * 999999 + 1) + "." + type.Extension); //or any other extension
        document.body.appendChild(link);
        link.click();
    },
    download(file, filename) {
        console.log(file);
        const url = window.URL.createObjectURL(new Blob([file]));

        const link = document.createElement("a");
        link.href = url;
        link.setAttribute("download", filename); //or any other extension
        document.body.appendChild(link);
        link.click();
    },
    
};