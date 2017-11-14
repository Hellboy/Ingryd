<?php
//include("../Institucion/institucion.entidad.php");
//include("../Categoria/categoria.entidad.php");
class InstitucionModel
{
	private $pdo;

	public function __CONSTRUCT()
	{
	try
		{
			$this->pdo = new PDO('mysql:host=localhost;dbname=mydb', 'root', '');
			$this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);		        
		}
		catch(Exception $e)
		{
			die($e->getMessage());
		}
	}
	
	public function Listar()
	{
		try
		{
			$result = array();

			$stm = $this->pdo->prepare("
				select *
				from  entidad e inner join institucion i
				where i.institucionID = e.entidadID AND e.estado = 1");
			$stm->execute();

			foreach($stm->fetchAll(PDO::FETCH_OBJ) as $r)
			{
				$alm = new entidad_institucion();

				$alm->__SET('entidadID', $r->entidadID);
				$alm->__SET('nombreInstitucion', $r->nombreInstitucion);
				$alm->__SET('descripcion', $r->descripcion);
				$alm->__SET('encargado', $r->encargado);
				$alm->__SET('direccion', $r->direccion);
				$alm->__SET('ciudad', $r->ciudad);
				$alm->__SET('departamento', $r->departamento);
				$alm->__SET('latitud', $r->latitud);
				$alm->__SET('longitud', $r->longitud);
				$alm->__SET('horario', $r->horario);
				$alm->__SET('estado', $r->estado);
				//$alm->__SET('institucionID', $r->institucionID);
				$alm->__SET('tipoInstitucion', $r->tipoInstitucion);

				$result[] = $alm;
			}

			return $result;
		}
		catch(Exception $e)
		{
			die($e->getMessage());
		}
	}
	public function Obtener($id)
	{
		try 
		{
			$stm = $this->pdo
			          ->prepare("select *
				from  entidad e inner join institucion i
				where e.entidadID = i.institucionID AND i.institucionID = ?");
			          

			$stm->execute(array($id));
			$r = $stm->fetch(PDO::FETCH_OBJ);

			$alm = new entidad_institucion();

			$alm->__SET('entidadID', $r->entidadID);
			$alm->__SET('nombreInstitucion', $r->nombreInstitucion);
			$alm->__SET('descripcion', $r->descripcion);
			$alm->__SET('encargado', $r->encargado);
			$alm->__SET('direccion', $r->direccion);
			$alm->__SET('ciudad', $r->ciudad);
			$alm->__SET('departamento', $r->departamento);
			$alm->__SET('latitud', $r->latitud);
			$alm->__SET('longitud', $r->longitud);
			$alm->__SET('horario', $r->horario);
			$alm->__SET('estado', $r->estado);
		  //$alm->__SET('institucionID', $r->institucionID);
			$alm->__SET('tipoInstitucion', $r->tipoInstitucion);
		
			return $alm;
		} catch (Exception $e) 
		{
			die($e->getMessage());
		}
	}
	


	public function Registrar(entidad_institucion $data)
	{
		try 
		{
		$sql = "INSERT INTO entidad(nombreInstitucion , descripcion , encargado , direccion, ciudad, departamento, latitud , longitud, horario , estado) VALUES (?, ?,  ?, ?, ?,?, ?,  ?, ?, ?)";
		 $sql2= "INSERT INTO institucion (institucionID, tipoInstitucion) VALUES (?,?)";

		$this->pdo->prepare($sql and $sql2)
		     ->execute(
			array(
				$data->__GET('nombreInstitucion'),
				$data->__GET('descripcion'),
				$data->__GET('encargado'),
				$data->__GET('direccion'),
				$data->__GET('ciudad'),
				$data->__GET('departamento'),
				$data->__GET('latitud'),
				$data->__GET('longitud'),
				$data->__GET('horario'),
				$data->__GET('estado'),
				$data->__GET('institucionID'),
				$data->__GET('tipoInstitucion')
				)

			);
		    
		
				
		     	
		} catch (Exception $e) 
		{
			die($e->getMessage());
		}
	}



	public function Actualizar(entidad_institucion $data)
	{
		try 
		{
			$sql = "UPDATE entidad SET 
						nombreInstitucion = ?,
	 					descripcion = ?,
					    encargado = ?,
					    direccion = ?,
	 					ciudad = ?,
					    departamento = ?,
					    latitud = ?,
	 					longitud = ?,
					    horario = ?
	 					estado = ?
				    WHERE tramiteID = ?";

			$sql2 = "UPDATE institucion SET 
						institucionID = ?,
	 					tipoInstitucion =?";
			$this->pdo->prepare($sql and $sql2)
			     ->execute(
				array(
				
					$data->__GET('nombreInstitucion'),
					$data->__GET('descripcion'),
					$data->__GET('encargado'),
					$data->__GET('direccion'),
					$data->__GET('ciudad'),
					$data->__GET('departamento'),
					$data->__GET('latitud'),
					$data->__GET('longitud'),
					$data->__GET('horario'),
					$data->__GET('estado'),
					$data->__GET('institucionID'),
					$data->__GET('tipoInstitucion')
					)
				);
		} catch (Exception $e) 
		{
			die($e->getMessage());
		}
	}
	public function Eliminar($id)
	{



		try 
		{
			$del = $this->pdo
			          ->prepare("UPDATE entidad SET 
					 
						estado        = 0
				    WHERE institucionID = entidadID and  entidadID = ?");			          

			$del->execute(array($id));

			

		} catch (Exception $e) 
		{
			die($e->getMessage());
		}
	}

}