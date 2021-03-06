$CompName = ("AL1d60050.endo.com")
<# ForEach ($Name in $CompName) {
	$Item = @{label="Drive";expression="DeviceID"},@{label="Size =
(GB)";expression={[Math]::Round($_.Size / =
1GB,2)}},@{label="FreeSpace =
(GB)";expression={[Math]::Round($_.FreeSpace / =
1GB,2)}},@{label="Percent =
Free";expression={[Math]::Round(($_.FreeSpace/$_.Size*100),2)}}
	$Name
	get-wmiobject -computername $Name -query "Select * from =
win32_logicaldisk"|
	Format-Table $item -auto
}
#>
foreach ($Name in $CompName)
	{
		Get-WmiObject Win32_volume -ComputerName $CompName |
 		where {$_.caption -like "*:\*"} | `
		select		@{name="Server Name";expression={$CompName}},
					@{name="Mount Point";expression={$_.caption}},
					@{name="Label";expression={$_.label}},
					@{name="FreeSpace (GB)";e={($_.freespace/1GB).tostring("F02")}},
					@{name="Capacity";expression={($_.Capacity/1GB).tostring("F02")}},
					@{name="Percent Free";expression={[Math]::Round(($_.FreeSpace/$_.Capacity*100),2)}}|
		ft -autosize
		}
