"use strict";

/* Aside & Navbar: dropdowns */
Array.from(document.getElementsByClassName("dropdown")).forEach(function (elA) {
    elA.addEventListener("click", function (e) {
        if (e.currentTarget.classList.contains("navbar-item")) {
            e.currentTarget.classList.toggle("active");
        } else {
            var dropdownIcon = e.currentTarget.getElementsByClassName("mdi")[1];
            e.currentTarget.parentNode.classList.toggle("active");
            dropdownIcon.classList.toggle("mdi-plus");
            dropdownIcon.classList.toggle("mdi-minus");
        }
    });
});
/* Aside Mobile toggle */

Array.from(document.getElementsByClassName("mobile-aside-button")).forEach(
    function (el) {
        el.addEventListener("click", function (e) {
            var dropdownIcon = e.currentTarget
                .getElementsByClassName("icon")[0]
                .getElementsByClassName("mdi")[0];
            document.documentElement.classList.toggle("aside-mobile-expanded");
            dropdownIcon.classList.toggle("mdi-forwardburger");
            dropdownIcon.classList.toggle("mdi-backburger");
        });
    }
);
/* NavBar menu mobile toggle */

Array.from(document.getElementsByClassName("--jb-navbar-menu-toggle")).forEach(
    function (el) {
        el.addEventListener("click", function (e) {
            var dropdownIcon = e.currentTarget
                .getElementsByClassName("icon")[0]
                .getElementsByClassName("mdi")[0];
            document
                .getElementById(e.currentTarget.getAttribute("data-target"))
                .classList.toggle("active");
            dropdownIcon.classList.toggle("mdi-dots-vertical");
            dropdownIcon.classList.toggle("mdi-close");
        });
    }
);
/* Modal: open */

Array.from(document.getElementsByClassName("--jb-modal")).forEach(function (
    el
) {
    el.addEventListener("click", function (e) {
        var modalTarget = e.currentTarget.getAttribute("data-target");
        document.getElementById(modalTarget).classList.add("active");
        document.documentElement.classList.add("clipped");
    });
});
/* Modal: close */

Array.from(document.getElementsByClassName("--jb-modal-close")).forEach(
    function (el) {
        el.addEventListener("click", function (e) {
            e.currentTarget.closest(".modal").classList.remove("active");
            document.documentElement.classList.remove("is-clipped");
        });
    }
);
/* Notification dismiss */

Array.from(
    document.getElementsByClassName("--jb-notification-dismiss")
).forEach(function (el) {
    el.addEventListener("click", function (e) {
        e.currentTarget.closest(".notification").classList.add("hidden");
    });
});

// fecth data kode history
const tombol_history = document.querySelectorAll(".tombol-histori");
tombol_history.forEach((el) => {
    el.addEventListener("click", function () {
        fetch(
            location.protocol +
                "//" +
                location.host +
                "/admin/settings/" +
                this.dataset.id
        )
            .then((response) => response.json())
            .then((data) => {
                let kode = "";
                data.forEach((d) => {
                    kode += `<tr>
                            <td class="text-center" data-label="Kode Sebelumnya"> ${d.kode_sebelumnya}</td>
                            <td class="text-center" data-label="Tanggal Perubahan"> ${d.tgl_perubahan}</td>
                            </tr>`;
                });
                const tabel_kode_history = document.querySelector(
                    ".tabel-kode-history"
                );
                tabel_kode_history.innerHTML = kode;
            });
    });
});
