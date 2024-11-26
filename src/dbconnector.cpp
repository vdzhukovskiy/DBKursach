#include "dbconnector.h"
#include "sqlquerymodel.h"

#include <QSqlTableModel>
#include <QSqlError>
#include <QSqlQuery>
#include <QDate>

#include <QSqlRecord>
#include <QSqlField>
#include <QMetaType>

#include <QDebug>

DbConnector::DbConnector(QObject *parent)
    : QObject{parent}
{}

DbConnector& DbConnector::instance()
{
    static DbConnector inst;
    return inst;
}

DbConnector::~DbConnector()
{
    if(db_)
        db_->close();
}

QStringList DbConnector::tables()
{
    auto tables = db_->tables();
    tables.insert(0, "");
    return tables;
}

QSqlDatabase &DbConnector::getDatabase()
{
    return *db_;
}

void DbConnector::addDatabase(QString const & hostName, QString const & databaseName, QString const & userName, QString const & password)
{
    if(db_ && db_->isOpen() && !db_->tables().empty())
    {
        emit connected();
        return;
    }
    if(db_ && db_->tables().empty())
    {
        db_->close();
    }

    db_ = std::make_shared<QSqlDatabase>(QSqlDatabase::addDatabase("QMYSQL", "conn"));
    db_->setHostName(hostName);
    db_->setDatabaseName(databaseName);
    db_->setUserName(userName);
    db_->setPassword(password);
    bool ok = db_->open();
    qDebug() << ok;
    if(!ok)
        return;

    emit connected();
}

void DbConnector::registerIncident(const QString &driverName, const QString &busNumber, const QString &date, const QString &description, const QString &severity)
{
    QSqlQuery insertIncidentQuery(DbConnector::instance().getDatabase());

    QDate formattedDate = QDate::fromString(date, "yyyy-MM-dd");
    QString sqlDate = formattedDate.toString("yyyy-MM-dd");



    const QString queryString = QString("INSERT INTO Incidents (bus_id, driver_id, data, description, severity) "
                                        "VALUES ("
                                        "(SELECT id FROM Buses WHERE license_plate = '%1'), "
                                        "(SELECT id FROM Drivers WHERE name = '%2'), "
                                        "'%3', "
                                        "'%4', "
                                        "'%5'"
                                        ")").arg(busNumber, driverName, sqlDate, description, severity);

    qDebug() << queryString;

    // insertIncidentQuery.setQuery(queryString, DbConnector::instance().getDatabase());

    qDebug() << insertIncidentQuery.exec(queryString);
    // QSqlTableModel table(nullptr, DbConnector::instance().getDatabase());
    // table.setTable("Incidents");

    // QSqlRecord record;

    // QSqlField busField("bus_id",  QMetaType::fromType<int>(), "Incidents");
    // busField.setValue(busNumber);

    // QSqlField driverField("driver_id",  QMetaType::fromType<int>(), "Incidents");
    // busField.setValue(busNumber);

    // record.append()
    // table.insertRecord()

    emit updateTable();
}
