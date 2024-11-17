#include "sqlquerymodel.h"
#include "dbconnector.h"

QHash<int, QByteArray> SqlQueryModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    for (int i = 0; i < record().count(); i ++) {
        roles.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
    }
    return roles;
}

QVariant SqlQueryModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    qDebug() << userRoleNames().at(section);
    return userRoleNames().at(section);
}

QVariant SqlQueryModel::data(const QModelIndex &index, int role) const
{
    QVariant value;
    if (index.isValid()) {
        if (role < Qt::UserRole) {
            value = QSqlQueryModel::data(index, role);
        } else {
            int columnIdx = role - Qt::UserRole - 1;
            QModelIndex modelIndex = this->index(index.row(), columnIdx);
            value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
        }
    }
    return value;
}

QString SqlQueryModel::queryStr() const
{
    return query().lastQuery();
}

void SqlQueryModel::setQueryStr(const QString &query)
{
    if(queryStr() == query)
        return;
    setQuery(query, DbConnector::instance().getDatabase());
    emit queryStrChanged();
}

QStringList SqlQueryModel::userRoleNames() const
{
    QStringList names;
    for (int i = 0; i < record().count(); i ++) {
        names << record().fieldName(i).toUtf8();
    }
    return names;
}
