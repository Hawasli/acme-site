<?php

$date = new DateTime();
$time_stamp = $date->getTimestamp();
$file_name = "temporal_certificate_" . $time_stamp;
$temporal_cert = shell_exec("./gen_temp_cert.bash $file_name");
$file = $file_name . '.zip';

if (file_exists($file)) {
    header('Content-Description: File Transfer');
    header('Content-Type: application/octet-stream');
    header('Content-Disposition: attachment; filename="'.basename($file).'"');
    header('Expires: 0');
    header('Cache-Control: must-revalidate');
    header('Pragma: public');
    header('Content-Length: ' . filesize($file));
    readfile($file);
    exit;
}
?>
