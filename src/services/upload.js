const multer = require("multer");
const storage = multer.memoryStorage(); // passa a configuração de armazenamento. memoryStorage é a memória ram
const upload = multer({storage});

module.exports = upload;