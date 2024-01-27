import express from "express";
import adminController from "../controller/admin-controller.js";
import { authAdmin } from "../middleware/auth.js";

const adminRouter = new express.Router();
adminRouter.use(authAdmin);
adminRouter.get("/admin/dashboard", adminController.index);
adminRouter
    .route("/admin/dashboard/cars")
    .get(adminController.cars)
    .post(adminController.addCar)
    .put(adminController.editCar)
    .delete(adminController.delCar);
adminRouter.get("/admin/dashboard/cars/add", adminController.addCar);
adminRouter.get("/admin/dashboard/cars/edit", adminController.editCar);
adminRouter
    .route("/admin/dashboard/clients")
    .get(adminController.clients)
    .post(adminController.addClient)
    .patch(adminController.editClient)
    .delete(adminController.delClient);
adminRouter.get("/admin/dashboard/clients/add", adminController.addClient);
adminRouter.get("/admin/dashboard/clients/edit", adminController.editClient);
adminRouter
    .route("/admin/dashboard/booking")
    .get(adminController.bookings)
    .patch(adminController.bookings);
adminRouter.get("/admin/dashboard/transactions", adminController.transactions);
adminRouter.route("/admin/dashboard/profile").get(adminController.profile);
// adminRouter.get("/admin/dashboard/profile/:photos", adminController.getPhotos);
adminRouter
    .route("/admin/dashboard/profile/setting")
    .get(adminController.profileSetting)
    .patch(adminController.profileSetting);

export { adminRouter };
