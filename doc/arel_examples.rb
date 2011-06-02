arel examples
--------------

group by query
--------------

select total_login as 'logins', count(*) as `users` 
  from (select u.user_id, sum(login_count) as total_login 
          from user u 
               inner join installation i on u.user_id = i.user_id
               group by u.user_id) g
  group by total_login;

+--------+-------+
| logins | users |
+--------+-------+
| 2      |     3 |
| 6      |     7 |
| 10     |     2 |
| 19     |     1 |
+--------+-------+

# Our relation variables(RelVars)
U =Table(:user, :as => 'U')
I =Table(:installation, :as => 'I')

# perform operations on relations
G =U.join(I)  #(implicit) will reference final joined relationship

#(explicit) predicate = Arel::Predicates::Equality.new U[:user_id], I[:user_id]
G =U.join(I).on( U[:user_id].eq(I[:user_id] ) 

# Keep in mind you MUST PROJECT for this to make sense
G.project(U[:user_id], I[:login_count].sum.as('total_login'))

# Now you can group
G=G.group(U[:user_id])

#from this group you can project and group again (or group and project)
# for the final relation
TL=G.project(G[:total_login].as('logins') G[:id].count.as('users')).group(G[:total_login])

