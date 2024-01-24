import executeQuery from "../config/database.js";

const getCars = async (page) => {
    const sizeOfPage = 10;
    const offset = (page - 1) * sizeOfPage;
    const data = await executeQuery({
        query: "SELECT * FROM Mobil LIMIT ? OFFSET ? ",
        values: [sizeOfPage, offset],
    });

    const total = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM Mobil",
    });
    const result = JSON.parse(JSON.stringify(data));

    const totalPages = Math.ceil(total[0].total / sizeOfPage);
    const maxPagination = 4;
    const halfMaxPagination = Math.floor(maxPagination / 2);
    let startPage = Math.max(page - halfMaxPagination, 1);
    let endPage = startPage + maxPagination - 1;
    if (endPage > totalPages) {
        endPage = totalPages;
        startPage = Math.max(endPage - maxPagination + 1, 1);
    }

    return {
        data: result,
        total_data: total[0].total,
        paging: {
            current_page: page,
            next_page: page + 1,
            prev_page: page - 1,
            start_page: startPage,
            end_page: endPage,
            total_page: totalPages,
        },
    };
};

const bookingCars = async (request) => {
    const data = await executeQuery({
        query: "INSERT INTO Booking (id_user, id_mobil, tgl_mulai_sewa, tgl_selesai_sewa) VALUES (?, ?, ?, ?)",
        values: [
            request.id_user,
            request.id_mobil,
            request.tgl_mulai_sewa,
            request.tgl_selesai_sewa,
        ],
    });
    const result = JSON.parse(JSON.stringify(data));
    return result[0];
};

const getBooking = async (id_user, page) => {
    const sizeOfPage = 10;
    const offset = (page - 1) * sizeOfPage;
    const data = await executeQuery({
        query: "SELECT *,DATE_FORMAT(tgl_booking, '%d-%m-%Y %H:%i') as tgl_booking, DATE_FORMAT(tgl_mulai_sewa, '%d-%m-%Y') as tgl_mulai_sewa, DATE_FORMAT(tgl_selesai_sewa, '%d-%m-%Y') as tgl_selesai_sewa, DATEDIFF (tgl_selesai_sewa, tgl_mulai_sewa) as hari FROM Booking WHERE id_user = ? LIMIT ? OFFSET ? ",
        values: [id_user, sizeOfPage, offset],
    });

    const total = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM Booking WHERE id_user = ?",
        values: [id_user],
    });

    const result = JSON.parse(JSON.stringify(data));

    const totalPages = Math.ceil(total[0].total / sizeOfPage);
    const maxPagination = 4;
    const halfMaxPagination = Math.floor(maxPagination / 2);
    let startPage = Math.max(page - halfMaxPagination, 1);
    let endPage = startPage + maxPagination - 1;
    if (endPage > totalPages) {
        endPage = totalPages;
        startPage = Math.max(endPage - maxPagination + 1, 1);
    }

    return {
        data: result,
        total_data: total[0].total,
        paging: {
            current_page: page,
            next_page: page + 1,
            prev_page: page - 1,
            start_page: startPage,
            end_page: endPage,
            total_page: totalPages,
        },
    };
};

const delBooking = async (bookingId) => {
    const data = await executeQuery({
        query: "DELETE FROM Booking WHERE id = ?",
        values: [bookingId],
    });
    const result = JSON.parse(JSON.stringify(data));
    return result[0];
};

export default {
    getCars,
    bookingCars,
    getBooking,
    delBooking,
};
