#include "dbconnector.h"

#include <QSqlTableModel>
#include <QDebug>

DbConnector::DbConnector(QObject *parent)
    : QObject{parent}
{}

DbConnector &DbConnector::instance()
{
    static DbConnector inst;
    return inst;
}

DbConnector::~DbConnector()
{
    if(db_)
        db_->close();
}

void DbConnector::addDatabase()
{
    if(db_)
        return;

    db_ = std::make_unique<QSqlDatabase>(QSqlDatabase::addDatabase("QMYSQL", "conn"));
    db_->setHostName("damsel8s.beget.tech");
    db_->setDatabaseName("damsel8s_zhukkp");
    db_->setUserName("damsel8s_zhukkp");
    db_->setPassword("Admin123");
    bool ok = db_->open();
    qDebug() << ok;

    QSqlTableModel model;
    model.setTable("Buses");
    // model.setFilter("salary > 50000");
    // model.setSort(2, Qt::DescendingOrder);
    model.select();


    // db_.setHostName("")
}
