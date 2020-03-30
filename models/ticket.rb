require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(tickets)
    @id = tickets['id'].to_i
    @customer_id = tickets['customer_id'].to_i
    @film_id = tickets['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id
      )VALUES
      (
        $1, $2
        )RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values)[0]
    @id = ticket['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    ticket_data = SqlRunner.run(sql)
    return ticket_data.map{|ticket| Ticket.new(ticket)}
  end


  def update()
    sql = "UPDATE tickets SET
    (
      customer_id,
      film_id

    ) = ($1, $2) WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end


def film()
  sql = "SELECT * FROM films WHERE films.id = $1"
  values = [@film_id]
  film_data = SqlRunner.run(sql, values)
  film_data = SqlRunner.run(sql, values)
  film = film_data.map{|film| Film.new(film)}
  return film.first()
end

def customer
  sql = "SELECT *
  FROM customers
  WHERE customers.id = $1"
  values = [@customer_id]
  customer_data = SqlRunner.run(sql, values)
  return customer_data.map{|customer| Customer.new(customer)}.first()
end



end
