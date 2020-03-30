require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(customers)
    @id = customers['id'].to_i
    @name = customers['name']
    @funds = customers['funds'].to_f
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
      )VALUES
      (
        $1, $2
        )RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)[0]
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customer_data = SqlRunner.run(sql)
    return customer_data.map{|customer| Customer.new(customer)}
  end

  def update()
    sql = "UPDATE customers SET (
    name,
    funds
    ) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM custoemrs WHERE id = $1"
    values = @id
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE tickets.customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return film_data.map{|film| Film.new(film)}
  end

  def tickets_sold()
    return films().count
  end

  def buy_a_ticket(ticket = 10.00)
    return if @funds < ticket.film.price
    @funds -= ticket.film.price
    update()
    
  end

end
