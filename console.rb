require( 'pry-byebug' )
require_relative( 'models/ticket' )
require_relative( 'models/customer' )
require_relative( 'models/film' )

Film.delete_all()
Customer.delete_all()
Ticket.delete_all()


film1 = Film.new({'title' => 'Era', 'price' => 9.00})
film1.save

film2 = Film.new({'title' => 'Blood', 'price' => 12.00})

film2.save

film3 = Film.new({'title' => 'A day', 'price' => 6.00})

film3.save

film4 = Film.new({'title' => 'Blade', 'price' => 11.00})
film4.save

film5 = Film.new({'title' => 'The Sun', 'price' => 10.00})
film5.save

customer1 = Customer.new(
  {
      'name'=> 'John',
      'funds'=> 140.00
  })

customer1.save()

customer2 = Customer.new(
  {
      'name'=> 'Billy',
      'funds'=> 160.00
  })
customer2.save()


customer3 = Customer.new(
  {
      'name'=> 'Peter',
      'funds'=> 200.00
  })
customer3.save()


customer4 = Customer.new(
  {
      'name'=> 'Melissa',
      'funds'=> 240.00
  })
customer4.save()


customer5 = Customer.new(
  {
      'name'=> 'Boris',
      'funds'=> 20.00
  })
customer5.save()


ticket1 = Ticket.new({'customer_id'=> customer1.id, 'film_id'=> film1.id})

ticket1.save()

ticket1 = Ticket.new({'customer_id'=> customer1.id, 'film_id'=> film2.id})

ticket2 = Ticket.new({'customer_id'=> customer2.id, 'film_id'=> film2.id})

ticket2.save()

ticket3 = Ticket.new({'customer_id'=> customer3.id, 'film_id'=> film3.id})

ticket3.save()

ticket4 = Ticket.new({'customer_id'=> customer4.id, 'film_id'=> film4.id})

ticket4.save()


ticket5 = Ticket.new({'customer_id'=> customer5.id, 'film_id'=> film5.id})

ticket5.save()

customer1.buy_a_ticket(ticket1)
customer1.buy_a_ticket(ticket3)

customer2.buy_a_ticket(ticket2)

customer3.buy_a_ticket(ticket4)
customer3.buy_a_ticket(ticket5)
customer3.buy_a_ticket(ticket5)
customer3.buy_a_ticket(ticket1)

customer4.buy_a_ticket(ticket2)
customer4.buy_a_ticket(ticket1)

binding.pry
nil
