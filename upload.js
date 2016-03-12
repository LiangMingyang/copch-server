/**
 * Created by 明阳 on 3/12/2016.
 */
var fn = function(req, res) {
    var dest, fileName, fs, l, tmpPath;

    fs = require('fs');
    tmpPath = req.file.path;
    l = tmpPath.split('/').length;
    fileName = req.file.filename + '_' + req.file.originalname ;
    dest = __dirname + "/public/uploads/" + fileName;

    fs.createReadStream(req.file.path)
        .pipe(fs.createWriteStream(dest))
        .on('error', function(error) {
            res.status(error.status || 500).json({error: error.message});
        })
        .on('finish', function() {
            html = "";
            html += "<script type='text/javascript'>";
            html += "    var funcNum = " + req.query.CKEditorFuncNum + ";";
            html += "    var url     = \"/uploads/" + fileName + "\";";
            html += "    var message = \"Uploaded file successfully\";";
            html += "";
            html += "    window.parent.CKEDITOR.tools.callFunction(funcNum, url, message);";
            html += "</script>";

            res.send(html);
        });
};

module.exports = fn;