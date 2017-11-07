from django_rdkit import models

class Compound(models.Model):

	name = models.CharField(max_length=256)
	molecule = models.MolField()

