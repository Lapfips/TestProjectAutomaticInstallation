Add-Type -AssemblyName PresentationFramework

# Interface utilisateur pour sélectionner les applications et les emplacements
$window = New-Object Windows.Window
$window.Title = "Installation d'Applications"
$window.Width = 400
$window.Height = 300

# Liste des applications disponibles à installer
$applications = @("Steam", "Firefox", "Visual Studio Code", "Adobe Reader")

# Liste des emplacements d'installation
$installLocations = @("C:\Program Files\", "D:\Applications\", "$env:USERPROFILE\Desktop\")

# Création des contrôles UI
$checkBoxes = @()
$comboBoxes = @()

$grid = New-Object Windows.Controls.Grid

# Création des checkboxes pour les applications
for ($i = 0; $i -lt $applications.Length; $i++) {
    $checkBox = New-Object Windows.Controls.CheckBox
    $checkBox.Content = $applications[$i]
    $checkBox.Margin = New-Object Windows.Thickness(10, $i * 30 + 10, 0, 0)
    $checkBoxes += $checkBox
    $grid.Children.Add($checkBox)

    $comboBox = New-Object Windows.Controls.ComboBox
    $comboBox.ItemsSource = $installLocations
    $comboBox.SelectedIndex = 0
    $comboBox.Margin = New-Object Windows.Thickness(150, $i * 30 + 10, 0, 0)
    $comboBoxes += $comboBox
    $grid.Children.Add($comboBox)
}

# Bouton de confirmation
$button = New-Object Windows.Controls.Button
$button.Content = "Installer"
$button.Margin = New-Object Windows.Thickness(150, $applications.Length * 30 + 20, 0, 0)
$button.Add_Click({
    # Récupération des choix de l'utilisateur
    for ($j = 0; $j -lt $checkBoxes.Length; $j++) {
        if ($checkBoxes[$j].IsChecked) {
            $selectedApp = $applications[$j]
            $selectedLocation = $comboBoxes[$j].SelectedItem
            Write-Output "Installer $selectedApp dans $selectedLocation"
            # Ajouter ici la logique pour copier les fichiers d'installation vers l'emplacement spécifié
        }
    }
    $window.Close()
})
$grid.Children.Add($button)

# Ajout du grid à la fenêtre
$window.Content = $grid

# Afficher la fenêtre
$window.ShowDialog() | Out-Null
