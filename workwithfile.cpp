#include "workwithfile.h"
#include <random>
#include <QDebug>
#include <QFileInfo>
#include <QDataStream>


WorkWithFile::WorkWithFile(QObject* parent) : QObject(parent)
{

}

void WorkWithFile::openAndModification(QList<QUrl> filePaths, QString mask, bool isRemove, QUrl dir)
{
    srand(static_cast<unsigned>(time(nullptr)));
    for(auto i = 0 ; i < filePaths.count(); i++){
        file.setFileName(filePaths.at(i).toLocalFile());
        if(file.open(QIODevice::ReadOnly))
        {
            QFileInfo fileInfo(file.fileName());
            QString fileName(fileInfo.fileName());
            QByteArray data;
            quint64 mask64 = mask.toULongLong(nullptr,16);
            QString path(dir.toLocalFile() + "/" + fileName);
            sFile.setFileName(path);
            sFile.open(QIODevice::WriteOnly);
            QDataStream out(&sFile);
            while(!file.atEnd()){
                QByteArray buff = file.read(8);
                qDebug() << buff;
                out << QByteArray::number(*(quint64*)buff.data()^mask64);
            }

            file.close();
            sFile.close();
            if(isRemove)
                file.remove();

        }
        else{
            qDebug() << "Не удалось открыть файл";
         }
    }
}

void WorkWithFile::saveFiles(QUrl dir, QString filePath, QByteArray &data)
{
    /*QString path(dir.toLocalFile() + "/" + filePath);
    sFile.setFileName(path);
    sFile.open(QIODevice::WriteOnly);
    QDataStream out(&sFile);
    out.append(*(quint64*)data()^mask)*/

}
bool WorkWithFile::fileExists(QList<QUrl> paths) {
    for(int i = 0; i < paths.count(); i++){
        qDebug() << i << " " << paths.at(i).toLocalFile();
        QFileInfo checkFile(paths.at(i).toLocalFile());
        if(!checkFile.exists())
            return false;
    }

    return true;
}
