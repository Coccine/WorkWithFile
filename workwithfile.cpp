#include "workwithfile.h"
#include <random>
#include <QDebug>
#include <QFileInfo>


WorkWithFile::WorkWithFile(QObject* parent) : QObject(parent)
{

}

void WorkWithFile::openAndModification(QList<QUrl> filePaths, QString mask, bool isRemove, QUrl dir)
{
    srand(static_cast<unsigned>(time(nullptr)));
    for(auto i = 0 ; i < filePaths.count(); i++){
        file.setFileName(filePaths.at(i).toLocalFile());
        if(file.open(QIODevice::ReadOnly | QFile::Text))
        {
            QFileInfo fileInfo(file.fileName());
            QString fileName(fileInfo.fileName());
            QString data = file.readAll();
            if(isRemove){
                file.remove();
            }
            file.close();
            QString dataTmp;
            for(int i = 0; i < data.size(); i++){
                dataTmp += QChar(data.at(i).unicode() ^ mask.at(rand() % mask.count()).unicode());
            }
            saveFiles(dir, fileName, dataTmp);
        }
        else{
            //qDebug() << "Не удалось открыть файл";
         }
    }
}

void WorkWithFile::saveFiles(QUrl dir, QString filePath, QString data)
{
    QString path(dir.toLocalFile() + "/" + filePath);
    sFile.setFileName(path);
    if(sFile.open(QIODevice::WriteOnly | QFile::Text)){
        sFile.write(data.toUtf8());
        sFile.close();
    }

}
bool WorkWithFile::fileExists(QString path) {
    QFileInfo checkFile(path);
    // check if file exists and if yes: Is it really a file and no directory?
    return checkFile.exists() && checkFile.isFile();
}
