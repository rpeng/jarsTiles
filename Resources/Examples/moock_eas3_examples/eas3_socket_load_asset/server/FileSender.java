import java.net.ServerSocket;
import java.net.Socket;
import java.io.IOException;
import java.io.InputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.BufferedOutputStream;

/**
 * FileSender is a simple server that takes a Socket connection and transmits a 
 * file after which the connection is closed.
 * 
 * Usage: java FileSender [port] [file]
 * 
 * [port] = the port on which the server will listen (on all local ip addresses) 
 *          for connections
 * [filename] = the path to the file which will be transmitted 
 *
 */
public class FileSender implements Runnable {
    private int port;
    private File file;
    private String filename;
    private ServerSocket server;
    private Thread thisThread;
    private byte[] bytes;

    public FileSender(int p, String f) {
        port = p;
        filename = f;
    }

    public void start() {
        InputStream is = null;
        try {
            // --- read the file in to our byte array
            file = new File(filename);
            is = new FileInputStream(file);
            bytes = new byte[(int)file.length()+1];
            int offset = 0;
            int byteRead = 0;
            while (offset < bytes.length && (byteRead=is.read(bytes, offset, bytes.length-offset)) >= 0) {
               offset += byteRead;
            }
            bytes[bytes.length-1] = 4;
            
            // --- create the ServerSocket
            server = new ServerSocket(port);
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (Exception e) { 
                    e.printStackTrace();
                    System.exit(1);
                }
            }
        }

        // --- start the Thread which will accept connections
        thisThread = new Thread(this);
        thisThread.start();
    }

    public void run() {
        // --- while the server is active...
        while (thisThread != null) {
            BufferedOutputStream ps = null;
            Socket socket = null;
            try {
                // --- ...accept socket connections (blocks until a connection is made)
                socket = server.accept();
                
                // --- create the output stream
                ps = new BufferedOutputStream(socket.getOutputStream()); 
                
                // --- write the bytes and close the connection
                ps.write(bytes);
                ps.close(); 
                ps = null;
                socket.close();
                socket = null;
            } catch(Exception e) {	
                thisThread = null;
                e.printStackTrace();
            } finally {
                if (ps != null) {
                    try {
                        ps.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                        System.exit(1);
                    }
                }
                if (socket != null) {
                    try {
                        socket.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                        System.exit(1);
                    }
                }            
            }
        }
        
        // --- cleanup the server
        if (server != null) {
            try {
                server.close();
            } catch (IOException e) {
                e.printStackTrace();
                System.exit(1);
            }
        }
    }

    public final static void main(String [] args) {
        // --- check for the proper number of arguments
        if (args.length != 2) {
            System.out.println("usage: java FileSender [port] [file]");
            System.exit(1);
        }
        
        try {
            // --- set the arguments to their proper type
            int port = Integer.parseInt(args[0]);
            String filename = args[1];
    
            // --- create and start the FileSender (which will run in its own thread)
            FileSender fs = new FileSender(port, filename);
            fs.start();
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        }
    }
}