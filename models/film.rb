require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(films)
    @id = films['id'].to_i if films['id']
    @title = films['title']
    @price = films['price'].to_f
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    film_data = SqlRunner.run(sql)
    return film_data.map{|film| Film.new(film)}

  end

  def update
    sql = "UPDATE films SET
    (
      title,
      price
    ) = ($1, $2)
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql,values)
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE * FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE tickets.film_id = $1"
    values = [@id]
    customer_data = SqlRunner.run(sql, values)
    return customer_data.map{|customer| Customer.new(customer)}
  end

  def viewers()
    return customers.count
  end

  def self.top_views()
    sorting = Film.all.sort! do |film3, film4|
                              film3.viewers <=> film4.viewers
                             end
    return sorting[0]
  end
end
