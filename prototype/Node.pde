public class Node<T>{
  T self;
  ArrayList<Node> child = new ArrayList<Node>();
  public Node(T e){
    self = e;
  }
  public void addObject(T e){
    child.add(new Node(e));
  }
}