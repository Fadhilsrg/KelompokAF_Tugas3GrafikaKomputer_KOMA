using UnityEngine;

public class spe : MonoBehaviour
{
    public Material Default;

    public Material sphereMaterial;

    new private MeshRenderer renderer;
    
    void Start()
    {
        renderer = GetComponent<MeshRenderer>();

        renderer.material = sphereMaterial;

        if (sphereMaterial == null)
        {
            Debug.LogError("Sphere material not assigned!");
            return;
        }
    }

}
