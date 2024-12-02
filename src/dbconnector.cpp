#include "dbconnector.h"

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

    qDebug() << insertIncidentQuery.exec(queryString);

    emit updateTable();
}

QStringList DbConnector::driverNames()
{
    QStringList names;
    names.append("");
    QSqlQuery query(getDatabase());

    if (query.exec("SELECT name FROM Drivers"))
    {
        while (query.next())
        {
            names.append(query.value(0).toString());
        }
    }
    else
    {
        qDebug() << "Failed to fetch driver names:" << query.lastError().text();
    }

    return names;
}

void DbConnector::deleteRow(const QString &id, const QString &tableName)
{
    QSqlQuery query(getDatabase());

    QString queryString = QString("DELETE FROM %1 WHERE id = :id").arg(tableName);

    query.prepare(queryString);
    query.bindValue(":id", id);

    if (query.exec())
    {
        qDebug() << "Row with ID"   << id << "deleted successfully from" << tableName;
        emit updateTable();
    }
    else
    {
        qDebug() << "Failed to delete row from" << tableName << ":" << query.lastError().text();
    }
}

void DbConnector::insertRow(const QString &tableName, const QStringList &values)
{
    QSqlQuery query(getDatabase());

    QStringList columns;
    QSqlQuery columnQuery(getDatabase());
    QString columnQueryStr = QString("SHOW COLUMNS FROM %1").arg(tableName);

    if (!columnQuery.exec(columnQueryStr)) {
        qDebug() << "Failed to fetch columns for table" << tableName << ":" << columnQuery.lastError().text();
        return;
    }

    while (columnQuery.next())
    {
        QString columnName = columnQuery.value(0).toString();
        if (columnQuery.value(5).toString() != "auto_increment")
        {
            columns.append(columnName);
        }
    }

    if (columns.size() != values.size())
    {
        qDebug() << "Column count doesn't match value count for table" << tableName;
        return;
    }

    QString columnNames = columns.join(", ");
    QString placeholders = QString("?,").repeated(values.size());
    placeholders.chop(1);

    QString queryString = QString("INSERT INTO %1 (%2) VALUES (%3)").arg(tableName, columnNames, placeholders);
    query.prepare(queryString);

    for (int i = 0; i < values.size(); ++i)
    {
        query.bindValue(i, values[i]);
    }

    if (query.exec())
    {
        qDebug() << "Row inserted successfully into" << tableName;
        emit updateTable();
    } else
    {
        qDebug() << "Failed to insert row into" << tableName << ":" << query.lastError().text();
    }
}
