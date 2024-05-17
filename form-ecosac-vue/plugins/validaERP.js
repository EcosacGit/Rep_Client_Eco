import _fun from '@/plugins/fun';
var validaERP_ = function() {

    var _private = {};

    _private.mesagge = function(form, el, elementName, msn, inp) {
        var span = $('<div class="xmsnErrorSpan" style="position:relative;"><span style="position:;color:#990000;">' + msn + '</span></div>');
        $(span).insertAfter(el);
    };

    _private.validaReglas = function(obj, element, elementName) {

        var required = eval('obj.items.' + element + '.required'),
            min = eval('obj.items.' + element + '.min'),
            max = eval('obj.items.' + element + '.max'),
            minlength = eval('obj.items.' + element + '.minlength'),
            maxlength = eval('obj.items.' + element + '.maxlength'),
            rangelength = eval('obj.items.' + element + '.rangelength'),
            range = eval('obj.items.' + element + '.range'),
            email = eval('obj.items.' + element + '.email'),
            url = eval('obj.items.' + element + '.url'),
            number = eval('obj.items.' + element + '.number'),
            digits = eval('obj.items.' + element + '.digits'),
            length = eval('obj.items.' + element + '.length'),
            cadena = eval('obj.items.' + element + '.cadena'),
            valor = eval('obj.items.' + element + '.value'),
            regular = eval('obj.items.' + element + '.regular'),
            msn = '',
            resp,
            error = 0,
            minl = 0,
            maxl = 0,
            reg = 0,
            req = 0,
            rang = 0;

        if (required) {
            resp = valor !== undefined ? valor.length > 0 : '';
            if (!resp) {
                error = 1;
                req = 1;
                msn = 'Campo Requerido';
            }
        }

        if (min) {
            if (valor < min && req == 0) {
                error = 1;
                msn = 'Ingrese un valor mayor o igual a ' + min + '.';
            }
        }
        if (max) {
            if (valor > max && req == 0) {
                error = 1;
                msn = 'Ingrese un valor menor o igual a ' + max + '.';
            }
        }
        if (minlength) {
            if ($.trim(valor).length > 0 && valor.length < minlength) {
                error = 1;
                minl = 1;
                msn = 'Ingrese un mínimo de ' + minlength + ' caracteres.';
            }
        }
        if (maxlength) {
            if ($.trim(valor).length > maxlength && valor.length > 0) {
                error = 1;
                maxl = 1;
                msn = 'Ingrese un máximo de ' + maxlength + ' caracteres.';
            }
        }

        if (rangelength && $.isArray(rangelength)) {
            resp = $.trim(valor).length >= rangelength[0] && $.trim(valor).length <= rangelength[1];
            if (!resp && maxl === 0 && minl === 0 && $.trim(valor).length > 0) {
                error = 1;
                msn = 'Ingrese un valor entre ' + rangelength[0] + ' y ' + rangelength[1] + ' caracteres.';
            }
        }
        if (range && $.isArray(range)) {
            resp = valor >= range[0] && valor <= range[1];
            if (!resp && $.trim(valor).length > 0) {
                error = 1;
                msn = 'Ingrese un valor entre ' + range[0] + ' y ' + range[1] + '.';
            }
        }

        if (email) {
            resp = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i.test(valor);
            if (!resp && $.trim(valor).length > 0 && maxl === 0 && minl === 0 && rang === 0) {
                error = 1;
                msn = 'Ingrese un email válido.';
            }
        }
        if (url) {
            resp = /^(https?|s?ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(valor);
            if (!resp && $.trim(valor).length > 0 && maxl === 0 && minl === 0 && rang === 0) {
                error = 1;
                msn = 'Ingrese una URL válida.';
            }
        }

        if (number) {
            resp = /^-?(?:\d+|\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/.test(valor);
            if (!resp && $.trim(valor).length > 0) {
                error = 1;
                msn = 'Ingrese un número válido.';
            }
        }
        if (digits) {
            resp = /^\d+$/.test(valor);
            if (!resp && $.trim(valor).length > 0) {
                error = 1;
                msn = 'Ingrese solo dígitos.';
            }
        }

        if (cadena) {
            if (!isNaN(valor) && $.trim(valor).length > 0) {
                error = 1;
                reg = 1;
                msn = 'No se permiten números.';
            }
        }
        if (length) {
            resp = $.trim(valor).length === length;
            if (!resp && valor.length > 0) {
                error = 1;
                msn = 'Ingrese ' + length + ' caracteres.';
            }
        }

        if (regular) {
            resp = /^[A-Za-záéíóúäëïöüñÁÉÍÓÚÑÄËÏÖÜ\d=#,:;._ ¿?()°-]+$/.test(valor);
            if (!resp && $.trim(valor).length > 0 && minl === 0 && maxl === 0) {
                error = 1;
                reg = 1;
                msn = 'No se permiten caracteres extraños.';
            }
        }

        if (error === 1) {
            _private.mesagge(obj.form, '#' + element, elementName, msn, '');
        }
        return error;
    };
    this.public = {};
    this.public.valida = function(obj) {
        var
            error2 = [],
            xerror2 = 0;

        if (obj.form.length === 0) {
            _fun.alert('Formulario [' + obj.form + '] no existe.', "warning");
        } else {
            $(obj.form).find('.xmsnErrorSpan').remove();
            var encontre, objElement, element, elementName;

            $.each(obj.items, function(index, value) {
                encontre = 0;
                objElement = index;
                element = $('#' + objElement);
                elementName = element[0].tagName.toLowerCase();

                if (elementName === 'div') {
                    element.removeClass('error');
                    error2.push(_private.validaReglas(obj, objElement, elementName));
                }
            });
        }

        for (var i in error2) {
            if (error2[i] === 1) {
                xerror2 = 1;
            }
        }

        if (xerror2 === 0) {
            return true;
            //obj.success;
        } else {
            if (obj.message !== undefined) {
                _fun.alert(obj.message, 'warning');
            } else {
                _fun.alert('Revise los campos marcados.', 'warning');
            }
            return false;
        }
    }

    return this.public
};
var validaERP = new validaERP_();
export default validaERP;