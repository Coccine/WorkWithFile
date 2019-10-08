#ifndef WORKWITHFILE_H
#define WORKWITHFILE_H

#include <QFile>
#include <QUrl>

class WorkWithFile : public QObject
{
    Q_OBJECT
public:
    WorkWithFile(QObject* parent = nullptr);
public:
    Q_INVOKABLE void openAndModification(QList<QUrl> filePaths, QString mask, bool isRemoveI, QUrl filePath);
    Q_INVOKABLE bool fileExists(QList<QUrl> paths);
private:
    QFile file;
    QFile sFile;
private:
    void saveFiles(QUrl dir, QString filePath, QByteArray& data);
};

#endif // WORKWITHFILE_H
