var app = require('express')();
var fs = require('fs');

app.get('/', (req, res) => {
  res.send('Hello world!');
});

app.get('/stats', (req, res) => {
  res.send({
    ips: require('child_process').execSync("ifconfig | grep inet | grep -v inet6 | awk '{gsub(/addr:/,\"\");print $2}'").toString().trim().split("\n"),
    hostname: require('child_process').execSync("hostname").toString(),
  });
});


app.listen(process.env.PORT || 8000);
