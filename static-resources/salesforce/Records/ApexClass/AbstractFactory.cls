public class AbstractFactory{


	interface IProcessor{

		void performOperation();
	}

	interface IStorage{

		void storeData();
	}

	interface IMonitor{

		void display();
	}


	class LEDMonitor implements IMonitor{

		public void display(){
			System.debug('Displaying in LED');
		}
	}

	class LCDMonitor implements IMonitor{

		public void display(){
			System.debug('Displaying in LCD');
		}
	}

	class SSDStorage implements IStorage{

		public void storeData(){
			System.debug('Storing SSD data');
		}
	}

	class HDDStorage implements IStorage{

		public void storeData(){
			System.debug('Storing HDD data');
		}
	}

	class QuadCore implements IProcessor{

		public void performOperation(){
			System.debug('Performing QuadCore operation');
		}
	}

	class DualCore implements IProcessor{

		public void performOperation(){
			System.debug('Performing DualCore operation');
		}
	}

	public interface IComputerFactory{

		IProcessor getProcessor();
		IStorage getStorage();
		IMonitor getMonitor();

	}

	public class HighPerformance implements IComputerFactory{

		public IProcessor getProcessor(){
			return new QuadCore();
		}

		public IStorage getStorage(){
			return new SSDStorage();
		}

		public IMonitor getMonitor(){
			return new LEDMonitor();
		}
	}

	public class StandardConfiguration implements IComputerFactory{

		public IProcessor getProcessor(){
			return new DualCore();
		}

		public IStorage getStorage(){
			return new HDDStorage();
		}

		public IMonitor getMonitor(){
			return new LCDMonitor();
		}
	}

	public class AssembleComputer{

		IComputerFactory computer;

		public AssembleComputer(IComputerFactory computer){
			this.computer = computer;
		}

		public void testCompleteSystem(){

			IProcessor processor = computer.getProcessor();
			IStorage storage = computer.getStorage();
			IMonitor monitor = computer.getMonitor();

			processor.performOperation();
			storage.storeData();
			monitor.display();
		}
	}	


}