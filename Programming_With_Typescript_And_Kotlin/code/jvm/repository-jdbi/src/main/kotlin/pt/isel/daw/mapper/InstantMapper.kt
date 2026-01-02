package pt.isel.daw.mapper

import org.jdbi.v3.core.mapper.ColumnMapper
import org.jdbi.v3.core.statement.StatementContext
import java.sql.ResultSet
import java.sql.SQLException
import java.sql.Timestamp

class InstantMapper : ColumnMapper<Timestamp> {
    @Throws(SQLException::class)
    override fun map(
        rs: ResultSet,
        columnNumber: Int,
        ctx: StatementContext,
    ): Timestamp = Timestamp(rs.getLong(columnNumber))
}