const router = require('express').Router();
const verifyJWT = require("../services/verifyJWT");

const userController = require("../controllers/userController");
const organizadorController = require("../controllers/organizadorController");
const eventoController = require("../controllers/eventoController");
const ingressoController = require("../controllers/ingressoController");
const compraController = require("../controllers/compraController");
const upload = require("../services/upload");

// Rotas userController
router.post('/user', userController.createUser);
router.get('/user', verifyJWT, userController.getAllUsers);
router.put('/user', userController.updateUser);
router.delete('/user/:id', userController.deleteUser);
router.post('/login', userController.loginUser);

// Rotas organizadorController
router.post('/organizador', organizadorController.createOrganizador);
router.get('/organizador', organizadorController.getAllOrganizador);
router.put('/organizador', organizadorController.updateOrganizador);
router.delete('/organizador/:id', organizadorController.deleteOrganizador);

// Rotas eventoController
router.post('/evento', upload.single("imagem"), eventoController.createEvento);
router.get('/evento', verifyJWT, eventoController.getAllEventos);
router.get("/evento/imagem/:id", eventoController.getImagemEvento);
router.put('/evento', eventoController.updateEvento);
router.delete('/evento/:id', eventoController.deleteEvento);
router.get('/evento/data', verifyJWT, eventoController.getEventosPorData);
router.get('/evento/semana/:data', verifyJWT, eventoController.getEventosSemana);


// Rotas ingressoController
router.post('/ingresso', ingressoController.createIngresso);
router.get('/ingresso', ingressoController.getAllIngressos);
router.put('/ingresso', ingressoController.updateIngresso);
router.delete('/ingresso/:id', ingressoController.deleteIngresso);

// Rotas compraController;
router.post('/comprasimples', compraController.registrarCompraSimples);
router.post('/compra', compraController.registrarCompra);


module.exports = router;