const express = require("express");
const app = express();
app.use("/", express.static(process.argv[2]));

const port = 8081;
app.listen(port, () => {
  console.log(`Listening on http://localhost:${port}/`);
});
