import express from "express";
import clientController from "../controller/client-controller.js";
import { authClient } from "../middleware/auth.js";

const clientRouter = new express.Router();
clientRouter.use(authClient);
clientRouter.get("/", clientController.index);
clientRouter
    .route("/cars")
    .get(clientController.getCars)
    .post(clientController.getCars);
clientRouter
    .route("/booking")
    .get(clientController.getBooking)
    .delete(clientController.delBooking);
clientRouter.get("/profile", clientController.profile);

export { clientRouter };
