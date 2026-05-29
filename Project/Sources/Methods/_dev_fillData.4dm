//%attributes = {}
var $dep : cs.DepartmentEntity
var $emp : cs.EmployeeEntity

// Clean existing data
ds.Employee.all().drop()
ds.Department.all().drop()

// Departments
var $departments : Collection
$departments:=New collection(\
"Engineering"; "Marketing"; "Sales"; "Human Resources"; "Finance")

var $depName : Text
For each ($depName; $departments)
	$dep:=ds.Department.new()
	$dep.name:=$depName
	$dep.save()
End for each

// Employees
var $employees : Collection
$employees:=New collection(\
New object("firstName"; "Alice"; "lastName"; "Martin"; "age"; 32; "city"; "Paris"; "salary"; 55000; "dep"; "Engineering");\
New object("firstName"; "Bob"; "lastName"; "Dupont"; "age"; 28; "city"; "Lyon"; "salary"; 42000; "dep"; "Marketing");\
New object("firstName"; "Claire"; "lastName"; "Bernard"; "age"; 45; "city"; "Marseille"; "salary"; 68000; "dep"; "Engineering");\
New object("firstName"; "David"; "lastName"; "Petit"; "age"; 35; "city"; "Toulouse"; "salary"; 51000; "dep"; "Sales");\
New object("firstName"; "Emma"; "lastName"; "Robert"; "age"; 29; "city"; "Nice"; "salary"; 47000; "dep"; "Human Resources");\
New object("firstName"; "François"; "lastName"; "Durand"; "age"; 52; "city"; "Bordeaux"; "salary"; 72000; "dep"; "Finance");\
New object("firstName"; "Gabrielle"; "lastName"; "Leroy"; "age"; 26; "city"; "Paris"; "salary"; 39000; "dep"; "Engineering");\
New object("firstName"; "Hugo"; "lastName"; "Moreau"; "age"; 41; "city"; "Nantes"; "salary"; 58000; "dep"; "Marketing");\
New object("firstName"; "Isabelle"; "lastName"; "Simon"; "age"; 37; "city"; "Strasbourg"; "salary"; 53000; "dep"; "Sales");\
New object("firstName"; "Jules"; "lastName"; "Laurent"; "age"; 30; "city"; "Lille"; "salary"; 44000; "dep"; "Finance"))

var $data : Object
For each ($data; $employees)
	$emp:=ds.Employee.new()
	$emp.firstName:=$data.firstName
	$emp.lastName:=$data.lastName
	$emp.age:=$data.age
	$emp.city:=$data.city
	$emp.salary:=$data.salary
	$emp.department:=ds.Department.query("name = :1"; $data.dep).first()
	$emp.save()
End for each

ALERT("Done: "+String(ds.Department.all().length)+" departments, "+String(ds.Employee.all().length)+" employees")
