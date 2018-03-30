<h1 align="center">Oferta de empleo</h1>

<p align="center">
    <b>{$job->title}</b><br/>
    {$job->details}
</p>

<h2 align="center">Detalles</h2>
<p align="center">
    <b>Se busca:</b>
    {$job->looking_for_profession}<br/>
</p>

<h2 align="center">Contacto</h2>
<p align="center">
    {$job->name}<br/>
    {$job->phone}
</p>

{space10}
<p align="center">
    {button href="TRABAJOS" caption="INICIO"}
    {button href="CHAT @{$job->username} Quisiera contactar contigo para asuntos de trabajo" caption="CONTACTAR" popup="true"}
</p>