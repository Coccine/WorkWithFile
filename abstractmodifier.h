#ifndef ABSTRACTMODIFIER_H
#define ABSTRACTMODIFIER_H

#include <QByteArray>
#include <QObject>

class AbstractModifier : public QObject
{
public:
    virtual void modifyData(const QByteArray &data) = 0;
signals:
    void progressChanged(int progress);
};

#endif // ABSTRACTMODIFIER_H
