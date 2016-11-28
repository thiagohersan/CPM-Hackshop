var port = process.env.PORT || 8080;

var express = require('express');
var exec = require('child_process').exec;

var app = express();
app.use(express.static('.', {index: 'index.html'}));

app.get('/say', function(req, res){
    var text = req.query.text;
    console.log('text: '+text);
    var cmd2 = 'espeak -vpt+f1 -k20 -s175 -a200 "'+text+'" 2> /dev/null';
    var cmd = './gootts.sh "'+text+'"';

    exec(cmd, function(error, stdout, stderr){});
    res.redirect('index.html');
});

app.listen(port);
