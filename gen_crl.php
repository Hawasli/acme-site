<?php
$gen_crl_path = "";
if (file_exists($gen_crl_path)) {
	$generate_crl = $gen_crl_path;
} else {
	die("The file resposible for generating a new CRL was not found");
}
$output = shell_exec($generate_crl, $_POST["user_name"]);

}