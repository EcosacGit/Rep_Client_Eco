import swal from "sweetalert2";

export default {
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
    }
}