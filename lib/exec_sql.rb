# encoding: utf-8
class ActiveRecord::Base
  # Execute SQL manually
  def self.exec_sql(*args)
    conn = ActiveRecord::Base.connection
    sql = ActiveRecord::Base.send(:sanitize_sql_array, args)
    conn.execute(sql)
  end
end