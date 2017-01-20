<?php
$functions  = function_exists('get_defined_functions')   ? get_defined_functions()   : [];
$interfaces = function_exists('get_declared_interfaces') ? get_declared_interfaces() : [];
$classes    = function_exists('get_declared_classes')    ? get_declared_classes()    : [];

$arrays = array_merge(
    $functions['internal'],
    $interfaces,
    $classes
);
sort($arrays);
$arrays = array_unique($arrays);
echo implode("\n", $arrays);
