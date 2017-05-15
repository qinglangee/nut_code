

var http = require('http');
const querystring = require('querystring');
var fs = require('fs');
var path = require('path');

//=========================================== 上传文件函数


function postFile(fileDataInfo, fileKeyValue, req) {
    var boundaryKey = Math.random().toString(16);
    var enddata = '\r\n----' + boundaryKey + '--';

    var dataLength = 0;
    var dataArr = new Array();
    for (var i = 0; i < fileDataInfo.length; i++) {
        var dataInfo = "\r\n----" + boundaryKey + "\r\n" + "Content-Disposition: form-data; name=\"" + fileDataInfo[i].urlKey + "\"\r\n\r\n" + fileDataInfo[i].urlValue;
        var dataBinary = new Buffer(dataInfo, "utf-8");
        dataLength += dataBinary.length;
        dataArr.push({
            dataInfo: dataInfo
        });
    }

    var files = new Array();
    for (var i = 0; i < fileKeyValue.length; i++) {
        var content = "\r\n----" + boundaryKey + "\r\n" + "Content-Type: application/octet-stream\r\n" + "Content-Disposition: form-data; name=\"" + fileKeyValue[i].urlKey + "\"; filename=\"" + path.basename(fileKeyValue[i].urlValue) + "\"\r\n" + "Content-Transfer-Encoding: binary\r\n\r\n";
        var contentBinary = new Buffer(content, 'utf-8'); //当编码为ascii时，中文会乱码。
        files.push({
            contentBinary: contentBinary,
            filePath: fileKeyValue[i].urlValue
        });
    }
    var contentLength = 0;
    for (var i = 0; i < files.length; i++) {
        var filePath = files[i].filePath;
        if (fs.existsSync(filePath)) {
            var stat = fs.statSync(filePath);
            contentLength += stat.size;
        } else {
            contentLength += new Buffer("\r\n", 'utf-8').length;
        }
        contentLength += files[i].contentBinary.length;
    }

    req.setHeader('Content-Type', 'multipart/form-data; boundary=--' + boundaryKey);
    req.setHeader('Content-Length', dataLength + contentLength + Buffer.byteLength(enddata));

    // 将参数发出
    for (var i = 0; i < dataArr.length; i++) {
        req.write(dataArr[i].dataInfo)
        //req.write('\r\n')
    }

    var fileindex = 0;
    var doOneFile = function() {
        req.write(files[fileindex].contentBinary);
        var currentFilePath = files[fileindex].filePath;
        if (fs.existsSync(currentFilePath)) {
            var fileStream = fs.createReadStream(currentFilePath, {bufferSize: 4 * 1024});
            fileStream.pipe(req, {end: false});
            fileStream.on('end', function() {
                fileindex++;
                if (fileindex == files.length) {
                    req.end(enddata);
                } else {
                    doOneFile();
                }
            });
        } else {
            req.write("\r\n");
            fileindex++;
            if (fileindex == files.length) {
                req.end(enddata);
            } else {
                doOneFile();
            }
        }
    };
    if (fileindex == files.length) {
        req.end(enddata);
    } else {
        doOneFile();
    }
}

exports.postFile = postFile;