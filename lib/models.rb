[
  {
    :name => 'Person',
    :fields => [
      {
        :name => 'name',
        :type => String,
        :length => 128,
        :validators => {
          :presence => true
        }
      }, {
        :name => 'email',
        :validators => {
          :presence => true,
          :format => {
            :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
          }
        }
      }, {
        :name => 'birthdate',
        :type => Date
      }
    ]
  }, {
    :name => 'Employee',
    :extends => 'Person',
    :includes => %w(Mongoid::Timestamps),
    :fields => [
      {
        :name => 'birthdate',
        :validators => {
          :presence => true
        }
      }, {
        :name => 'salary',
        :type => Float,
        :default => 1000.00
      }
    ]
  }
]