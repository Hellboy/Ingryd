<?php
class entidad_sucursal
{
	private $entidadID;
	private $nombreInstitucion;
	private $descripcion;
	private $encargado;
	private $direccion;
	private $ciudad;
	private $departamento;
	private $latitid;
	private $longitud;
	private $horario;
	private $estado;
	
	private $institucionID;
	private $tipoInstitucion;

	PRIVATE $sucursalID;

	public function __GET($k){ return $this->$k; }
	public function __SET($k, $v){ return $this->$k= $v; }
	
}

	

?>