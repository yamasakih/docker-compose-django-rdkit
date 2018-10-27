def main():
    import sys
    from rdkit import Chem
    from rdkit.Chem import Descriptors

    smiles = sys.argv[1]
    mol = Chem.MolFromSmiles(smiles)
    mw = Descriptors.MolWt(mol)
    print(mw)


if __name__ == '__main__':
    main()
