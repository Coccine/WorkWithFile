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
private:
    QFile file;
    QFile sFile;
private:
    bool fileExists(QString path);
    void saveFiles(QUrl dir, QString filePath, QString data);
};

#endif // WORKWITHFILE_H
